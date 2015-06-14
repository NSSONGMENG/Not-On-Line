//
//  LoadCurrentData.h
//  PLBWaining
//
//  Created by songmeng on 15/4/27.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoadInfomationData;

@interface LoadInfomationData : NSObject
@property (nonatomic,strong)NSMutableArray * basicInfoArray;    //基本信息model数组

-(void)requestDataByURLString:(NSString *)URLString option:(NSString *)option;

@end
