//
//  HistoryInfoViewController.m
//  PLBWaining
//
//  Created by songmeng on 15/4/1.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "HistoryInfoViewController.h"
#import "Define.h"
#import "LoadInfomationData.h"
#import "Singleton.h"
#import "InfomationModel.h"
#import "BasicInfoCell.h"

@interface HistoryInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UIDatePicker       * picker;       //日期选择器
@property (nonatomic,strong) LoadInfomationData * loadData;     //加载数据
@property (nonatomic,strong) NSArray            * allKeys;      //保存所有属性，方便cell数设置
@property (nonatomic,strong) InfomationModel    * historyInfoModel; //历史数据model类
@property (nonatomic,strong) UITableView        * tableView;
@property (nonatomic,strong) UIImageView        * upperView;
@property (nonatomic,assign) NSInteger            flag;         //用来rightItem的button类型
@property (nonatomic,strong) UIButton           * rightButton;
@end

@implementation HistoryInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _flag = 0;
    [self layoutNavigationItem];
    
    [self layoutSubViews];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loaadHistoryData:) name:@"loadhistoryinfo" object:nil];
}

//加载NavigationItem
-(void)layoutNavigationItem{
    self.navigationItem.rightBarButtonItem = nil;
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    
    if (_flag == 0) {
        [rightButton setTitle:@"查询" forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(searchHistoryData) forControlEvents:UIControlEventTouchUpInside];
        
        _flag = 1;
    }else if (_flag == 1){
        [rightButton setTitle:@"返回" forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(backToPicker) forControlEvents:UIControlEventTouchUpInside];
        _flag = 0;
    }
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//加载日期选择器和button
-(void)layoutSubViews{

    self.picker.center = CGPointMake(kWidth/2, kHeight/2-50);
    _picker.timeZone = [NSTimeZone localTimeZone];      //设置时区
    _picker.datePickerMode = UIDatePickerModeDate;      //只显示日期
    _picker.maximumDate = [NSDate date];                //可查询的最晚时间
    _picker.minimumDate = [NSDate dateWithTimeIntervalSince1970:(360*41+215)*24*3600];   //可查询的最早时间:2011年1月1日
    [self.view addSubview:_picker];
    
    UIButton * searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchButton.frame = CGRectMake(0, 0, kWidth/3, kWidth/8);
    searchButton.center = CGPointMake(kWidth/2, kHeight/4*3);
    [searchButton setBackgroundImage:[UIImage imageNamed:@"search_button.png"] forState:UIControlStateNormal];
    [searchButton setTitle:@"查  询" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchButton setTitleShadowColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchHistoryData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    
    
}

//历史数据查询
-(void)searchHistoryData{
    //获取用户通过UIDatePicker设置的日期
    NSDate * date = [self.picker date];
    //创建日期格式
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //使用自定义日期格式格式化日期
    NSString * dateString = [formatter stringFromDate:date];
    NSString * id_string = [NSString stringWithFormat:@"&id=%@",[Singleton basicInfoModel].name_id];
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@",kHistoryInfoURL,dateString,id_string];
    
    //数据请求
    [self.loadData requestDataByURLString:urlString option:@"history" ];
    
    [self changeView_tableViewAppear];
}

//返回查询界面
-(void)backToPicker{
    [self layoutNavigationItem];
    [self changeView_tableViewDisappear];

}


#pragma  mark  -------------------数据处理--------------------
-(void)loaadHistoryData:(NSNotification *)notifaction{
    _allKeys = [[NSArray alloc] initWithArray:[[Singleton currentDic] allKeys]];
    _historyInfoModel = [[InfomationModel alloc] init];
    _historyInfoModel = [Singleton historyInfo];
    
    [self.tableView reloadData];
    [self layoutNavigationItem];
}

#pragma  mark  -------------------TableView--------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allKeys.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BasicInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:kHistoryInfoCell];
    if (!cell) {
        cell = [[BasicInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kHistoryInfoCell];
    }
    
    switch (indexPath.row) {
        case 0:{
            cell.nameLable.text = @"站点：";
            if(_historyInfoModel.name.length > 0){
                cell.contantLable.text = _historyInfoModel.name;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 1:{
            cell.nameLable.text = @"数据更新时间：";
            if (_historyInfoModel.datatime.length > 0) {
                cell.contantLable.text = _historyInfoModel.datatime;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 2:{
            cell.nameLable.text = @"侵染等级：";
            if (_historyInfoModel.qinran.length > 0) {
                cell.contantLable.text = _historyInfoModel.qinran;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 3:{
            cell.nameLable.text = @"温度(°C)：";
            if (_historyInfoModel.wendu.length> 0) {
                cell.contantLable.text = _historyInfoModel.wendu;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 4:{
            cell.nameLable.text = @"湿度(%)：";
            if (_historyInfoModel.shidu.length > 0) {
                cell.contantLable.text = _historyInfoModel.shidu;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 5:{
            cell.nameLable.text = @"露点(°C)：";
            if (_historyInfoModel.ludian.length > 0) {
                cell.contantLable.text = _historyInfoModel.ludian;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 6:{
            cell.nameLable.text = @"雨量(mm)：";
            if (_historyInfoModel.yuliang) {
                cell.contantLable.text = _historyInfoModel.yuliang;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 7:{
            cell.nameLable.text = @"风速(m/s)：";
            if (_historyInfoModel.fengsu.length > 0) {
                cell.contantLable.text = _historyInfoModel.fengsu;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 8:{
            cell.nameLable.text = @"风向：";
            cell.contantLable.text = _historyInfoModel.fengxiang;
            break;
        }
        case 9:{
            cell.nameLable.text = @"极大风速(m/s)：";
            if (_historyInfoModel.jidafengsu.length > 0) {
                cell.contantLable.text = _historyInfoModel.jidafengsu;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 10:{
            cell.nameLable.text = @"对应风向：";
            if (_historyInfoModel.duiyingfengxiang.length > 0) {
                cell.contantLable.text = _historyInfoModel.duiyingfengxiang;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 11:{
            cell.nameLable.text = @"气压(hPa)：";
            if (_historyInfoModel.qinran.length > 0) {
                cell.contantLable.text = _historyInfoModel.qiya;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 12:{
            cell.nameLable.text = @"蒸散量(mm)：";
            if (_historyInfoModel.zhengsanliang.length > 0) {
                cell.contantLable.text = _historyInfoModel.zhengsanliang;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 13:{
            cell.nameLable.text = @"太阳辐射(w/m²)：";
            if (_historyInfoModel.taiyangfushe.length > 0) {
                cell.contantLable.text = _historyInfoModel.taiyangfushe;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 14:{
            cell.nameLable.text = @"紫外线(Index)：";
            if (_historyInfoModel.ziwai.length > 0) {
                cell.contantLable.text = _historyInfoModel.ziwai;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 15:{
            cell.nameLable.text = @"土壤湿度(%)：";
            if (_historyInfoModel.turangshidu.length > 0) {
                cell.contantLable.text = _historyInfoModel.turangshidu;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 16:{
            cell.nameLable.text = @"土壤温度(°C)：";
            if (_historyInfoModel.turangwendu.length > 0) {
                cell.contantLable.text = _historyInfoModel.turangwendu;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 17:{
            cell.nameLable.text = @"最高温度(°C)：";
            if (_historyInfoModel.zuigaowendu.length > 0) {
                cell.contantLable.text = _historyInfoModel.zuigaowendu;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        default:{
            cell.nameLable.text = @"最低温度(°C)：";
            if (_historyInfoModel.zuidiwendu.length > 0) {
                cell.contantLable.text = _historyInfoModel.zuidiwendu;
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    tableView.tableFooterView = [[UIView alloc] init];
    return cell;
}

#pragma  mark  -------------------懒加载--------------------

-(UIButton *)rightButton{
    if (_rightButton != nil) {
        return _rightButton;
    }
    _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    return _rightButton;
}

-(LoadInfomationData *)loadData{
    if (!_loadData) {
        _loadData = [[LoadInfomationData alloc] init];
    }
    return _loadData;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight-64-self.tabBarController.tabBar.frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIImageView *)upperView{
    if (_upperView == nil) {
        _upperView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    }
    return _upperView;
}

- (UIDatePicker *)picker{
    if (_picker == nil) {
        _picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, kWidth/4*3, kWidth/2)];
    }
    return _picker;
}
#pragma  mark  -------------------tableView出现--------------------
-(void)changeView_tableViewAppear{
    CATransition * transition = [CATransition animation];
    
    transition.duration = 1.0f;
    [_upperView removeFromSuperview];
    [self.view addSubview:self.tableView];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    [self.view.layer addAnimation:transition forKey:@"animation"];
}

#pragma  mark  -------------------tableView消失--------------------
-(void)changeView_tableViewDisappear{
    CATransition * transition = [CATransition animation];
    
    transition.duration = 1.0f;
    [self.view addSubview:_upperView];
    [self.tableView removeFromSuperview];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    [self.view.layer addAnimation:transition forKey:@"animation"];
}
@end
