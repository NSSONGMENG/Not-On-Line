//
//  AddressListTVC.m
//  PLBWaining
//
//  Created by songmeng on 15/4/1.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "AddressListTVC.h"
#import "Define.h"
#import "AddressDetailTabBarController.h"
#import "AddressListCell.h"
#import "BasicInfoModel.h"
#import "Singleton.h"

@interface AddressListTVC()
@property (nonatomic,strong)NSMutableArray * addressInfoArray;
@end
@implementation AddressListTVC

-(void)viewDidLoad{
    [super viewDidLoad];
   
    _addressInfoArray = [NSMutableArray array];
    _addressInfoArray = [Singleton basicInfoArray]; //通过单例获得所有地理信息
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadData:)
                                                 name:@"loadBasicInfo"
                                               object:nil];
}

- (void)loadData:(NSNotification *)notifaction{
    _addressInfoArray = nil;
    _addressInfoArray = [Singleton basicInfoArray]; //通过单例获得所有地理信息
    [self.tableView reloadData];
}

#pragma  mark  -------------------TableCell--------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _addressInfoArray.count;
}
//cell重用
-(AddressListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdent = @"addressCell";
    AddressListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (!cell) {
        cell = [[AddressListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;   //cell辅助效果 >
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;            //cell点击效果
    
    //cell赋值
    BasicInfoModel * address = [self.addressInfoArray objectAtIndex:indexPath.row];
    cell.addressName.text = address.name;
    cell.communication.text = address.communication;
    
    //侵染等级，根据侵染等级的不同给字体设置不同的颜色
    NSString * qinran = [cell.communication.text substringToIndex:3];
    NSString * dengji = [qinran substringFromIndex:2];
    
    if ([cell.communication.text isEqual:@"无侵染"]) {
        cell.addressName.textColor = [UIColor colorWithRed:118.0/255.0 green:228.0/255.0 blue:69.0/225.0 alpha:1];
        cell.communication.textColor = [UIColor colorWithRed:118.0/255.0 green:228.0/255.0 blue:69.0/225.0 alpha:1];
    }else if([dengji isEqual:@"1"]){
        cell.addressName.textColor = [UIColor colorWithRed:46.0/255.0 green:139.0/255.0 blue:87.0/225.0 alpha:1];
        cell.communication.textColor = [UIColor colorWithRed:46.0/255.0 green:139.0/255.0 blue:87.0/225.0 alpha:1];
    }else if ([dengji isEqual:@"2"]){
        cell.addressName.textColor = [UIColor colorWithRed:255.0/255.0 green:153.0/255.0 blue:18.0/225.0 alpha:1];
        cell.communication.textColor = [UIColor colorWithRed:255.0/255.0 green:153.0/255.0 blue:18.0/225.0 alpha:1];
    }else if ([dengji isEqual:@"3"]){
        cell.addressName.textColor = [UIColor colorWithRed:255.0/255.0 green:97.0/255.0 blue:0.0/225.0 alpha:1];
        cell.communication.textColor = [UIColor colorWithRed:255.0/255.0 green:97.0/255.0 blue:0.0/225.0 alpha:1];
    }else if ([dengji isEqual:@"4"]){
        cell.addressName.textColor = [UIColor colorWithRed:210.0/255.0 green:105.0/255.0 blue:30.0/255.0 alpha:1];
        cell.communication.textColor = [UIColor colorWithRed:210.0/255.0 green:105.0/255.0 blue:30.0/255.0 alpha:1];
    }else if ([dengji isEqual:@"5"]){
        cell.addressName.textColor = [UIColor redColor];
        cell.communication.textColor = [UIColor redColor];
    }else if ([dengji isEqual:@"6"]){
        cell.addressName.textColor = [UIColor colorWithRed:128.0/255.0 green:42.0/255.0 blue:42.0/255.0 alpha:1];
        cell.communication.textColor = [UIColor colorWithRed:128.0/255.0 green:42.0/255.0 blue:42.0/255.0 alpha:1];
    }else if ([dengji isEqual:@"7"]){
        cell.addressName.textColor = [UIColor blueColor];
        cell.communication.textColor = [UIColor blueColor];
    }else{
        cell.addressName.textColor = [UIColor colorWithRed:11.0/255.0 green:23.0/255.0 blue:70.0/255.0 alpha:1];
        cell.communication.textColor = [UIColor colorWithRed:11.0/255.0 green:23.0/255.0 blue:70.0/255.0 alpha:1];
    }
    
    tableView.tableFooterView = [[UIView alloc] init];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //初始化TabbarController
    AddressDetailTabBarController * addressDetailTBC = [[AddressDetailTabBarController alloc] init];
    
    //推出Controller的方式
    addressDetailTBC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    //给单例赋值，在推出的Controller中便可通过单例获取对象
    [Singleton setAddress_model:[_addressInfoArray objectAtIndex:indexPath.row]];
    
    //模态
    [self.navigationController presentViewController:addressDetailTBC animated:YES completion:nil];
}




@end
