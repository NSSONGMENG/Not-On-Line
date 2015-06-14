//
//  MapVC.m
//  PLBWaining
//
//  Created by songmeng on 15/4/1.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "MapVC.h"
#import "Define.h"
#import "SomeLable.h"
#import "Singleton.h"
#import "BasicInfoModel.h"
//#import "LoadBasicInfo.h"
#import "LoadInfomationData.h"

@interface MapVC ()<MKMapViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray * addressArray;             //地址条数
@property (nonatomic,strong) UIButton       * button;                   //right tabbar item
@property (nonatomic,strong) NSMutableDictionary * addressDictionary;   //存放除当前地址外的所有地址,地址切换时使用
@property (nonatomic,strong) NSMutableDictionary * currentAddressDic;   //只存放当前地址
@property (nonatomic,assign) int flag;      //标记tableview是否展示 1:已展示  2:未展示
@property (nonatomic,strong) UITableView    * tableView;
@property (nonatomic,strong) LoadInfomationData * loadBasicInfo;
@property (nonatomic,copy)   NSString       * privence;                 //省
@property (nonatomic,strong) MKMapView      * mapView;                  //地图
@end

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadData:)
                                                 name:@"loadBasicInfo"
                                               object:nil];

}
//加载数据
-(void)loadData:(NSNotification *)notifaction{
    _flag = 0;
    if (_mapView != nil){
        [_mapView removeFromSuperview];
        _mapView = nil;
    }
    
    #pragma  mark  -------------------加载数据--------------------
    _addressArray = [NSMutableArray array];
    _addressArray = [Singleton basicInfoArray];
    
    #pragma  mark  -------------------地址切换--------------------
    //获取当前地址
    NSString * privence = [[_addressArray firstObject] sheng];
    if (privence.length > 0) {
        _currentAddressDic = [NSMutableDictionary dictionaryWithObject:[self.addressDictionary objectForKey:privence]
                                                                forKey:privence];
        [self.addressDictionary removeObjectForKey:privence];
    }
    
    //加载navigation item
    [self layoutNavigationItem];
    
    //加载地图
    [self.view addSubview:self.mapView];
    
    //打头针颜色说明
    [self layoutPinStateView];
}



#pragma  mark  -------------------代理方法--------------------
//地图标注回调方法
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    static NSString *  reuseIdent = @"PIN_ANNOTATION";
    
    MKPinAnnotationView * annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdent];
    if(annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                         reuseIdentifier:reuseIdent];
    }
    
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    annotationView.highlighted = YES;
    annotationView.draggable = YES;
    
    //如果有侵染情况，则显示红色
    NSString * qinran = [annotation.subtitle substringToIndex:3];
    //侵染等级，根据侵染等级的不同给字体设置不同的颜
    NSString * dengji = [qinran substringFromIndex:2];
    
    if ([dengji isEqual:@"染"]) {
        annotationView.pinColor = MKPinAnnotationColorGreen;
    }else if([dengji isEqual:@"1"] || [dengji isEqual:@"2"] || [dengji isEqual:@"3"]){
        annotationView.pinColor = MKPinAnnotationColorPurple;
    }else {
        annotationView.pinColor = MKPinAnnotationColorRed;
    }
    return annotationView;
}
//地图加载错误时回调方法
- (void)mapViewDidFailLoadingMap:(MKMapView *)theMapView withError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"地图加载错误"
                          message:[error localizedDescription]
                          delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil];
    [alert show];
}

#pragma  mark  -------------------地址切换--------------------

- (void)layoutNavigationItem{
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame = CGRectMake(0, 0, 60, 40);
    [_button setTitle:[[_currentAddressDic allKeys] firstObject] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(changeAddress) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:_button];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)changeAddress{
    if ([self.view viewWithTag:400] != nil) {
        [[self.view viewWithTag:400] removeFromSuperview];
    }
    
    if (_flag == 0) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = self.view.bounds;
        button.backgroundColor = [UIColor lightGrayColor];
        button.alpha = 0.3;
        [button setTag:400];
        [button addTarget:self action:@selector(removeTableView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth-60, 64, 60, [_addressDictionary allKeys].count * 25)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        _flag = 1;
    }else if (_flag == 1 && _tableView){
        [self.tableView removeFromSuperview];
        _flag = 0;
    }
    
    //动画
    CABasicAnimation * anamated = [CABasicAnimation animation];
    if (anamated) {
        CATransition *animation = [CATransition animation];
        [animation setType:kCATransitionFade];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [animation setDuration:0.5f];
        [self.view.layer addAnimation:animation forKey:@"UITableViewReloadDataAnimationKey"];
    }
    
}

//撤销下拉地址选择菜单
- (void)removeTableView{
    UIButton * button = (UIButton *)[self.view viewWithTag:400];
    [button removeFromSuperview];
    [self.tableView removeFromSuperview];
    _flag = 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_addressDictionary allKeys].count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdent = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdent];
    }
    cell.detailTextLabel.text = [[_addressDictionary allValues] objectAtIndex:indexPath.row];
    cell.detailTextLabel.alpha = 0;
    
    cell.textLabel.text = [[_addressDictionary allKeys] objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //地址位置交换
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [_button setTitle:cell.textLabel.text forState:UIControlStateNormal];
    [_addressDictionary setObject:[[_currentAddressDic allValues] firstObject] forKey:[[_currentAddressDic allKeys] firstObject]];
    [_currentAddressDic removeAllObjects];
    [_currentAddressDic setObject:cell.textLabel.text forKey:cell.detailTextLabel.text];
    [_addressDictionary removeObjectForKey:cell.detailTextLabel.text];
    [tableView removeFromSuperview];
    _flag = 0;
    
    //数据加载
    self.loadBasicInfo = [[LoadInfomationData alloc] init];
//    [_loadBasicInfo requestBasicInfoWithURLString:[kOtherInfoURL stringByAppendingString:cell.detailTextLabel.text] ];
    [_loadBasicInfo requestDataByURLString:[kOtherInfoURL stringByAppendingString:cell.detailTextLabel.text] option:@"basic"];
}

//大头针颜色描述
-(void)layoutPinStateView{
    //    UIView * stateView = [[UIView alloc] initWithFrame:CGRectMake(10, kHeight - 160, 100, 110)];
    
    //无浸染
    //    MKPinAnnotationView * greenPin = [[MKPinAnnotationView alloc] initWithFrame:CGRectMake(5, 0, 10, 30)];
    //    greenPin.pinColor = MKPinAnnotationColorGreen;
    ////    greenPin.backgroundColor = [UIColor yellowColor];
    //    [stateView addSubview:greenPin];
    
    //    MKPinAnnotationView * puplePin = [[MKPinAnnotationView alloc] initWithFrame:CGRectMake(5, 35, 10, 30)];
    //    puplePin.pinColor = MKPinAnnotationColorPurple;
    ////    puplePin.backgroundColor = [UIColor yellowColor];
    //    [stateView addSubview:puplePin];
    
    //    MKPinAnnotationView * redPin = [[MKPinAnnotationView alloc] initWithFrame:CGRectMake(5, 70, 30, 30)];
    //    redPin.backgroundColor = [UIColor redColor];
    //    redPin.pinColor = MKPinAnnotationColorRed;
    //    [stateView addSubview:redPin];
    
    SomeLable * greenLable = [[SomeLable alloc] initWithFrame:CGRectMake(15, kHeight - 130, 70, 20)];
    greenLable.textAlignment = NSTextAlignmentLeft;
    [greenLable setFont:[UIFont systemFontOfSize:15]];
    greenLable.textColor = [UIColor colorWithRed:61.0/255.0 green:216.0/255.0 blue:76.0/255.0 alpha:1];
    greenLable.highlighted = YES;
    greenLable.text = @"无侵染";
    [self.mapView addSubview:greenLable];
    
    //1～3级侵染
    SomeLable * pupleLable = [[SomeLable alloc] initWithFrame:CGRectMake(15, kHeight - 110, 70, 20)];
    pupleLable.textAlignment = NSTextAlignmentLeft;
    [pupleLable setFont:[UIFont systemFontOfSize:15]];
    pupleLable.textColor = [UIColor colorWithRed:189.0/255.0 green:70.0/255.0 blue:220.0/255.0 alpha:1];
    pupleLable.highlighted = YES;
    pupleLable.text = @"1~3级";
    [self.mapView addSubview:pupleLable];
    
    //4级以上侵染
    SomeLable * redLable = [[SomeLable alloc] initWithFrame:CGRectMake(15, kHeight - 90, 70, 20)];
    redLable.textAlignment = NSTextAlignmentLeft;
    [redLable setFont:[UIFont systemFontOfSize:15]];
    redLable.textColor = [UIColor colorWithRed:1 green:30.0/255.0 blue:29.0/255.0 alpha:1];
    redLable.highlighted = YES;
    redLable.text = @"4级及以上";
    [self.mapView addSubview:redLable];
    
    //    [stateView addSubview:greenLable];
    //    [stateView addSubview:pupleLable];
    //    [stateView addSubview:redLable];
    //    [self.view addSubview:stateView];
}

//地图懒加载
- (MKMapView *)mapView{
    if (_mapView == nil){
        _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
        _mapView.delegate = self;
        
        _mapView.mapType = MKMapTypeStandard;                    //使用标准地图风格
        _mapView.zoomEnabled = YES;                              //地图可缩放
        _mapView.scrollEnabled = YES;                            //地图可滚动
        
        //给地图添加地点标注
        NSMutableArray * notationArray = [NSMutableArray array];
        for (int i = 0;i < _addressArray.count;i ++) {
            BasicInfoModel * basic = [_addressArray objectAtIndex:i];
            CLLocationCoordinate2D coordinate = {basic.weidu,basic.jingdu};
            MKCoordinateSpan span = {8,8};                      //地图显示范围
            MKCoordinateRegion regon = {coordinate,span};
            [_mapView setRegion:regon];
            
            MKPointAnnotation * point = [[MKPointAnnotation alloc] init];
            point.coordinate = coordinate;
            point.title = basic.name;
            point.subtitle = basic.communication;
            [notationArray addObject:point];
        }
        [_mapView addAnnotations:[[NSArray alloc] initWithArray:notationArray]];
    }
    return _mapView;
}

- (NSMutableDictionary *)addressDictionary{

    _addressDictionary = nil;
    _addressDictionary = [NSMutableDictionary dictionaryWithObjects:@[@"yunnan",@"guizhou",@"sichuan",@"hubei",@"heilongjiang",@"neimeng",@"shanxi",@"chongqing",@"ningxia"] forKeys:@[@"云南",@"贵州",@"四川",@"湖北",@"黑龙江",@"内蒙",@"陕西",@"重庆",@"宁夏"]];

    return _addressDictionary;
}

//- (UITableView *)tableView{
//    if (_tableView == nil) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth-60, 64, 60, [_addressDictionary allKeys].count * 25)];
//    }
//    return _tableView;
//}

/*
////加载地图
//-(void)layoutMKMapView{
//    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
//    _mapView.delegate = self;
//    
//    _mapView.mapType = MKMapTypeStandard;                    //使用标准地图风格
//    _mapView.zoomEnabled = YES;                              //地图可缩放
//    _mapView.scrollEnabled = YES;                            //地图可滚动
//    
//#pragma  mark  -------------------给地图添加点--------------------
//    NSMutableArray * notationArray = [NSMutableArray array];
//    for (int i = 0;i < _addressArray.count;i ++) {
//        BasicInfoModel * basic = [_addressArray objectAtIndex:i];
//        CLLocationCoordinate2D coordinate = {basic.weidu,basic.jingdu};
//        MKCoordinateSpan span = {10,10};                      //地图显示范围
//        MKCoordinateRegion regon = {coordinate,span};
//        [_mapView setRegion:regon];
//        
//        MKPointAnnotation * point = [[MKPointAnnotation alloc] init];
//        point.coordinate = coordinate;
//        point.title = basic.name;
//        point.subtitle = basic.communication;
//        [notationArray addObject:point];
//    }
//    [_mapView addAnnotations:[[NSArray alloc] initWithArray:notationArray]];
//    [self.view addSubview:_mapView];
//    
//}
*/
@end
