//
//  CurrentInfoViewController.m
//  PLBWaining
//
//  Created by songmeng on 15/4/1.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "CurrentInfoViewController.h"
#import "Define.h"
#import "BasicInfoCell.h"
#import "InfomationModel.h"
#import "LoadInfomationData.h"
#import "Singleton.h"

@interface CurrentInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView        * tableVeiw;
@property (nonatomic,strong) InfomationModel    * currentInfo;
@property (nonatomic,strong) LoadInfomationData * loadData;
@property (nonatomic,strong) NSDictionary       * currentInfoDic;
@property (nonatomic,strong) NSArray            * allKeys;
@property (nonatomic,strong) NSArray            * allValues;
@end

@implementation CurrentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //数据请求
    self.loadData = [[LoadInfomationData alloc] init];
    
    //拼接
    NSString * urlString = [NSString stringWithFormat:@"%@%@",kCurrentInfoURL,[[Singleton basicInfoModel] name_id]];
    [_loadData requestDataByURLString:urlString option:@"current"];
    
    //加载tableViewb
    [self layoutTableView];
    

    //注册通知，当实时信息请求处理完毕并给单例赋值后会发送通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData:) name:@"loadcurrentinfo" object:nil];
}

-(void)layoutTableView{
    self.tableVeiw = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableVeiw.delegate = self;
    _tableVeiw.dataSource = self;
    [self.view addSubview:_tableVeiw];
}

#pragma  mark  -------------------TableView--------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.allKeys.count == 0){
        return 1;
    }
    return self.allKeys.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BasicInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:kCurrentInfoCell];
    if (!cell) {
        cell = [[BasicInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCurrentInfoCell];
    }
    if (self.allKeys.count > 1) {
        switch (indexPath.row) {
            case 0:{
                cell.nameLable.text = @"站点：";
                if(_currentInfo.name.length > 0){
                    cell.contantLable.text = _currentInfo.name;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            case 1:{
                cell.nameLable.text = @"数据更新时间：";
                if (_currentInfo.datatime.length > 0) {
                    cell.contantLable.text = _currentInfo.datatime;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            case 2:{
                cell.nameLable.text = @"侵染等级：";
                if (_currentInfo.qinran.length > 0) {
                    cell.contantLable.text = _currentInfo.qinran;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            case 3:{
                cell.nameLable.text = @"温度(°C)：";
                if (_currentInfo.wendu.length> 0) {
                    cell.contantLable.text = _currentInfo.wendu;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            case 4:{
                cell.nameLable.text = @"湿度(%)：";
                if (_currentInfo.shidu.length > 0) {
                    cell.contantLable.text = _currentInfo.shidu;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            case 5:{
                cell.nameLable.text = @"露点(°C)：";
                if (_currentInfo.ludian.length > 0) {
                    cell.contantLable.text = _currentInfo.ludian;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            case 6:{
                cell.nameLable.text = @"雨量(mm)：";
                if (_currentInfo.yuliang) {
                    cell.contantLable.text = _currentInfo.yuliang;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            case 7:{
                cell.nameLable.text = @"风速(m/s)：";
                if (_currentInfo.fengsu.length > 0) {
                    cell.contantLable.text = _currentInfo.fengsu;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            case 8:{
                cell.nameLable.text = @"风向：";
                cell.contantLable.text = _currentInfo.fengxiang;
                break;
            }
            case 9:{
                cell.nameLable.text = @"极大风速(m/s)：";
                if (_currentInfo.jidafengsu.length > 0) {
                    cell.contantLable.text = _currentInfo.jidafengsu;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            case 10:{
                cell.nameLable.text = @"对应风向：";
                if (_currentInfo.duiyingfengxiang.length > 0) {
                    cell.contantLable.text = _currentInfo.duiyingfengxiang;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            case 11:{
                cell.nameLable.text = @"气压(hPa)：";
                if (_currentInfo.qinran.length > 0) {
                    cell.contantLable.text = _currentInfo.qiya;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            case 12:{
                cell.nameLable.text = @"蒸散量(mm)：";
                if (_currentInfo.zhengsanliang.length > 0) {
                    cell.contantLable.text = _currentInfo.zhengsanliang;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            case 13:{
                cell.nameLable.text = @"太阳辐射(w/m²)：";
                if (_currentInfo.taiyangfushe.length > 0) {
                    cell.contantLable.text = _currentInfo.taiyangfushe;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            case 14:{
                cell.nameLable.text = @"紫外线(Index)：";
                if (_currentInfo.ziwai.length > 0) {
                    cell.contantLable.text = _currentInfo.ziwai;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            case 15:{
                cell.nameLable.text = @"土壤湿度(%)：";
                if (_currentInfo.turangshidu.length > 0) {
                    cell.contantLable.text = _currentInfo.turangshidu;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            case 16:{
                cell.nameLable.text = @"土壤温度(°C)：";
                if (_currentInfo.turangwendu.length > 0) {
                    cell.contantLable.text = _currentInfo.turangwendu;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            case 17:{
                cell.nameLable.text = @"最高温度(°C)：";
                if (_currentInfo.zuigaowendu.length > 0) {
                    cell.contantLable.text = _currentInfo.zuigaowendu;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
            default:{
                cell.nameLable.text = @"最低温度(°C)：";
                if (_currentInfo.zuidiwendu.length > 0) {
                    cell.contantLable.text = _currentInfo.zuidiwendu;
                }else{
                    cell.contantLable.text = @"---";
                }
                break;
            }
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.tableHeaderView = [[UIView alloc] init];
    tableView.tableFooterView = [[UIView alloc] init];
    return cell;
}

#pragma  mark  -------------------通过单例获取数据--------------------
-(void)loadData:(NSNotification *)notification{
    self.currentInfoDic = [NSDictionary dictionaryWithDictionary:[Singleton currentDic]];
    self.allKeys = [_currentInfoDic allKeys];       //获取所有key组成的数组，表numberOfCell
    self.currentInfo = [Singleton currentInfo];
    [self.tableVeiw reloadData];
}


@end
