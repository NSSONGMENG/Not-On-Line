//
//  AddressInfo.h
//  PotatoWarning
//
//  Created by songmeng on 15/3/30.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//
#pragma Mark 保存数据信息类

#import <UIKit/UIKit.h>

@interface BasicInfoModel:NSObject <NSCoding>

@property (nonatomic,strong)NSString * datatime;      //更新时间

@property (nonatomic,assign)double     jingdu;        //经度
@property (nonatomic,assign)double     weidu;         //纬度
@property (nonatomic,strong)NSString * wendu;         //温度
@property (nonatomic,strong)NSString * communication; //侵染状态
@property (nonatomic,strong)NSString * sheng;         //省
@property (nonatomic,strong)NSString * shengID;       //省ID
@property (nonatomic,strong)NSString * shiID;         //市ID
@property (nonatomic,strong)NSString * xianID;        //县ID
@property (nonatomic,strong)NSString * linksto;       //
@property (nonatomic,strong)NSString * address;       //详细地址
@property (nonatomic,strong)NSString * qingrandengji; //侵染等级
@property (nonatomic,strong)NSString * name;          //地点名
@property (nonatomic,strong)NSString * shi;           //市
@property (nonatomic,strong)NSString * xian;          //县
@property (nonatomic,strong)NSString * yuliang;       //雨量
@property (nonatomic,strong)NSString * shidu;         //湿度
@property (nonatomic,strong)NSString * name_id;       //id

//按姓名排序
-(NSComparisonResult)compareByCommunication:(BasicInfoModel *)nextModel;

@end