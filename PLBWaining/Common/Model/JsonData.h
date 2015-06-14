//
//  JsonData.h
//  PotatoWarning
//
//  Created by songmeng on 15/3/30.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//
#pragma Mark JSON数据解析

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JsonData : NSObject<NSURLConnectionDataDelegate>
@property (nonatomic,retain)NSMutableData * mutableData;
@property (nonatomic,retain)NSMutableArray * addressInfoArray;  //保存AddressInfo对象

@end
