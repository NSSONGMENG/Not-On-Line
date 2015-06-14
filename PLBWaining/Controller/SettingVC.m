//
//  SettingVC.m
//  PLBWaining
//
//  Created by songmeng on 15/4/1.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "SettingVC.h"
#import "Define.h"
#import "SettingInfoVC.h"
#import "LoginViewController.h"

@interface SettingVC ()

@end

@implementation SettingVC

#pragma Mark --------- 软件信息 --------
static         NSString * softwareInfo = @"名       称：马铃薯晚疫病监测预警系统\n软件版本：1.0\n软件简介：\n       马铃薯晚疫病监测预警系统主要由气象监测设备、无线通讯设备、数据采集分析软件和web数据浏览分发四大部分。\n       它将监测终端、无线通讯、web技术、植保知识、疫病知识、专家经验、人工智能技术、地理信息系统(GIS)、决策支持系统(DSS)有机地结合起来，能够对各个监测站安装地区的马铃薯晚疫病信息进行实时监测、预警和诊断，对农户种植的马铃薯是否染病以及是否需要药物防治进行科学的预测决策，直接为三农发展建设服务。";

static         NSString * softwareFunction = @"马铃薯晚疫病监测预警系统主要功能：\n1、多监测点同步实时气象数据采集，避免人工干预，真正做到无值守模式。\n2、针对各监测点的气象数据，实时提供马铃薯侵染分析等。\n3、以web方式向相关部门和机构共享马铃薯监测点的相关气象数据及其侵染分析数据。\n4、通过安装手机客户端软件，达到任何时间、任何地点对气象数据的实时浏览。";

static         NSString * companyInfo = @"      北京汇思君达科技有限公司是一家专注于基于农业气象方面无线数据采集、数据分析，并提供相关系统集成服务的高科技公司。\n      公司成立至今，始终秉承“质量第一、品牌优秀、价格合理、服务至上”的宗旨，努力为广大客户提供优质的产品设备和完整的系统解决方案。";

static         NSString * contactUs = @"联系方式：北京汇思君达科技有限公司\n技术支持：010-84786221\n联  系  人：张君\n电子邮箱：support@hsjdtech.com\n网       址：http://www.hsjdtech.com\n公司地址：北京市朝阳区东亚望京中心A座611";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layoutSubViews];  //添加table view
}

//添加table view 方法实现
-(void)layoutSubViews{
    //添加tableView
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    
    //设置代理
    tableView.delegate = self;
    tableView.dataSource = self;
}

//设置TableView的section的数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

//设置TableView每个section的row数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

//设置每个row上的cell，与cell的重用有关
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //设置cell的重用标识
    static NSString * cellIdenfier = @"cell";
    //从重用队列里取出cell对象
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdenfier];
    //如果没有取出，必须初始化响应的cell对象
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenfier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    //设置row内容
    cell.textLabel.text = [NSString stringWithFormat:@"section:%ld  row:%ld",(long)indexPath.section,(long)indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"软件信息";
    }else if (indexPath.section == 0 && indexPath.row == 1){
        cell.textLabel.text = @"软件功能";
    }else if (indexPath.section == 1 && indexPath.row == 0){
        cell.textLabel.text = @"公司简介";
    }else if(indexPath.section == 1 && indexPath.row == 1){
        cell.textLabel.text = @"联系我们";
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;   //cell右侧>图标
    cell.selectionStyle = UITableViewCellSelectionStyleNone;            //cell选中效果
    
    return cell;
    
}


//cell已经被选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingInfoVC * infoVC = [[SettingInfoVC alloc] init];
    
    infoVC.view.backgroundColor = [UIColor lightGrayColor];
    if (indexPath.section == 0 && indexPath.row == 0) {         //点击软件信息
        infoVC.title = @"软件信息";
        infoVC.info = softwareInfo;
    }
    else if (indexPath.section == 0 && indexPath.row == 1){     //点击软件功能
        infoVC.title = @"软件功能";
        infoVC.info = softwareFunction;
    }else if (indexPath.section == 1 && indexPath.row == 0){    //点击公司简介
        infoVC.title = @"公司简介";
        infoVC.info = companyInfo;
    }else{                                                      //点击联系我们
        infoVC.title = @"联系我们";
        infoVC.info = contactUs;
    }
    
    [self.navigationController pushViewController:infoVC
                                         animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 100;
    }
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 300)];
        footerView.userInteractionEnabled = YES;
        //添加button
        UIButton * unsubscribeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        unsubscribeButton.frame = CGRectMake((kWidth - 200)/2, 60, 200, 40);
        unsubscribeButton.layer.cornerRadius = 10;
        [unsubscribeButton setBackgroundImage:[UIImage imageNamed:@"Action_Button_Red"] forState:UIControlStateNormal];
        [unsubscribeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [unsubscribeButton setTitle:@"注销登录" forState:UIControlStateNormal];
        [unsubscribeButton addTarget:self action:@selector(nsubscribeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:unsubscribeButton];
        
        return footerView;
    }
    return nil;
}

#pragma  mark  -------------------账号注销--------------------
-(void)nsubscribeButtonClicked:(UIButton *)button{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"系统将清除您的帐号信息,确认注销？" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction * cancle  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"account"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"password"];
        
        LoginViewController * loginVC = [[LoginViewController alloc] init];
        [self.navigationController presentViewController:loginVC animated:NO completion:nil];
        
    }];
    [alert addAction:cancle];
    [alert addAction:confirm];
    
    [super.navigationController presentViewController:alert animated:YES completion:nil];
}

@end
