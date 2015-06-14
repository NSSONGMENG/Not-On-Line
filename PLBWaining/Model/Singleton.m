//
//  Singleton.m
//  PLBWaining
//
//  Created by songmeng on 15/4/27.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

static Singleton * single = nil;
+(Singleton *)shareSingleton{
    @synchronized(self){
        if (single == nil) {
            single = [[Singleton alloc] init];
        }
    }
    return single;
}

#pragma  mark  -------------------getter方法--------------------
+(NSString *)province{
    return single.province;
}

+(NSMutableArray *)addressArray{
    return single.addressArray;
}

+(NSMutableArray *)basicInfoArray{
    return single.basicInfoArray;
}

+(BasicInfoModel *)basicInfoModel{
    return single.basicInfoModel;
}

+(InfomationModel *)currentInfo{
    return single.currentInfo;
}

+(InfomationModel *)historyInfo{
    return single.historyInfo;
}

+(NSDictionary *)currentDic{
    return single.currentDic;
}

+(BOOL)networkEnable{
    return single.networkEnable;
}


#pragma  mark  -------------------setter方法--------------------
+(void)setProvince:(NSString *)province{
    single.province = province;
}

+(void)setAddress_model:(BasicInfoModel *)basicInfoModel{
    single.basicInfoModel = basicInfoModel;
}

+(void)setBasicInfoArray:(NSMutableArray *)arr{
    single.basicInfoArray = [NSMutableArray array];
    single.basicInfoArray = arr;
}

+(void)setAddressArray:(NSMutableArray *)arr{
    single.addressArray = [NSMutableArray array];
    single.addressArray = arr;
}

+(void)setCurrentInfo:(InfomationModel *)current_info{
    single.currentInfo = current_info;
}

+(void)setHistoryInfo:(InfomationModel *)history_info{
    single.historyInfo = history_info;
}

+(void)setCurrentDic:(NSDictionary *)dic{
    single.currentDic = nil;
    single.currentDic = [NSDictionary dictionaryWithDictionary:dic];
}

+(void)setNetworkEnable:(BOOL)enable{
    single.networkEnable = enable;
}

@end
