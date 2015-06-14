//
//  BasicInfoViewController.m
//  PLBWaining
//
//  Created by songmeng on 15/4/1.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "BasicInfoViewController.h"
#import "BasicInfoCell.h"
#import "Define.h"
#import "Singleton.h"

@interface BasicInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutTableView];
}

-(void)layoutTableView{
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;      //外观代理
    tableView.dataSource = self;    //数据源代理
    [self.view addSubview:tableView];
}

#pragma  mark  -------------------TAbleView--------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BasicInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:kBasicInfoCell];
    if (!cell) {
        cell = [[BasicInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kBasicInfoCell];
    }
    
    switch (indexPath.row) {
        case 0:{
            cell.nameLable.text = @"名称：";
            if([Singleton basicInfoModel].name.length > 0){
                cell.contantLable.text = [[Singleton basicInfoModel] name];
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 1:{
            cell.nameLable.text = @"地址：";
            if ([Singleton basicInfoModel].address.length > 0) {
                cell.contantLable.text = [[Singleton basicInfoModel] address];
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 2:{
            cell.nameLable.text = @"温度(°C)：";
            if ([Singleton basicInfoModel].wendu.length > 0) {
                cell.contantLable.text = [[Singleton basicInfoModel] wendu];
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        case 3:{
            cell.nameLable.text = @"湿度(%)：";
            cell.contantLable.text = [NSString stringWithFormat:@"%@",[[Singleton basicInfoModel] shidu]];
            break;
        }
        case 4:{
            cell.nameLable.text = @"雨量(mm/hr)：";
            cell.contantLable.text = [NSString stringWithFormat:@"%@",[[Singleton basicInfoModel] yuliang]];
            break;
        }
        case 5:{
            cell.nameLable.text = @"侵染状态：";
            if ([Singleton basicInfoModel].communication.length > 0) {
                cell.contantLable.text = [[Singleton basicInfoModel] communication];
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
        default:{
            cell.nameLable.text = @"最新更新时间：";
            if ([Singleton basicInfoModel].datatime.length > 0) {
                cell.contantLable.text = [[Singleton basicInfoModel] datatime];
            }else{
                cell.contantLable.text = @"---";
            }
            break;
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;    //点击效果为无
    tableView.tableFooterView = [[UIView alloc] init];          //去除多余的cell分割线
    return cell;
}



@end
