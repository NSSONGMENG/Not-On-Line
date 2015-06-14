//
//  AddressInfo.m
//  PotatoWarning
//
//  Created by songmeng on 15/3/30.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//
#pragma Mark 保存数据信息类

#import "BasicInfoModel.h"

@implementation BasicInfoModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

-(void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqual:@"id"]) {
        self.name_id = value;
    }else if ([key isEqual:@"wendu"]){
        self.wendu = [NSString stringWithFormat:@"%@",value];
    }
}

#pragma  mark  -------------------归档／反归档--------------------
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
//    if (self) {
//        return self;
//    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
}

//重写description方法
-(NSString *)description{
    return [NSString stringWithFormat:@"省：%@ 市：%@ 县：%@ 名称：%@ id：%@",_sheng,_shi,_xian,_name,_name_id];
}

//排序
-(NSComparisonResult)compareByCommunication:(BasicInfoModel *)nextModel{
    if ([self.communication compare:nextModel.communication] > 0) {
        return NSOrderedDescending;
    }else if ([self.communication isEqual:nextModel.communication]){
        return NSOrderedSame;
    }else{
        return NSOrderedAscending;
    }
}

@end
