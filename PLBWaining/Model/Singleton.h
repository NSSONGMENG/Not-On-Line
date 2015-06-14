//
//  Singleton.h
//  PLBWaining
//
//  Created by songmeng on 15/4/27.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//
/*
 在AddressList中点击cell跳转时修改单例的值，从而达到单例传值的目的
 */
#import <Foundation/Foundation.h>
#import "BasicInfoModel.h"
#import "InfomationModel.h"

@class Singleton;
@interface Singleton : NSObject
@property (nonatomic,strong)NSString             * province;        //省份
@property (nonatomic,strong)BasicInfoModel       * basicInfoModel;  //基本信息
@property (nonatomic,strong)NSMutableArray       * basicInfoArray;  //基本信息数组
@property (nonatomic,strong)NSMutableArray       * addressArray;    //地址数组
@property (nonatomic,strong)InfomationModel      * currentInfo;     //实时信息
@property (nonatomic,strong)InfomationModel      * historyInfo;     //历史数据
@property (nonatomic,strong)NSDictionary         * currentDic;      //通过currentDic中的allKeys取得实时数据中cell数量
@property (nonatomic,assign)BOOL                   networkEnable;   //网络是否可用

+(Singleton *)shareSingleton;

#pragma  mark  -------------------getter方法--------------------
+(NSString *)province;
+(BasicInfoModel *)basicInfoModel;
+(NSMutableArray *)basicInfoArray;
+(NSMutableArray *)addressArray;
+(InfomationModel *)currentInfo;
+(InfomationModel *)historyInfo;
+(NSDictionary *)currentDic;
+(BOOL)networkEnable;


#pragma  mark  -------------------setter方法--------------------
+(void)setProvince:(NSString *)province;
+(void)setAddress_model:(BasicInfoModel *)basicInfoModel;
+(void)setBasicInfoArray:(NSMutableArray *)arr;
+(void)setAddressArray:(NSMutableArray *)arr;
+(void)setCurrentInfo:(InfomationModel *)current_info;
+(void)setHistoryInfo:(InfomationModel *)history_info;
+(void)setCurrentDic:(NSDictionary *)dic;
+(void)setNetworkEnable:(BOOL)enable;
@end
