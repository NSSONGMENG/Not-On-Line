//
//  SomeView.h
//  aaaDrawing
//
//  Created by songmeng on 15/5/8.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SomeView : UIView

/*
 *总天数
 */
@property (nonatomic,assign) NSInteger numberOfDay;

/*
 *第一天
 */
@property (nonatomic,strong) NSDate    * firstDate;

/*
 *包含日期数据的数组
 */
@property (nonatomic,strong) NSMutableArray   * dateArray;

@end
