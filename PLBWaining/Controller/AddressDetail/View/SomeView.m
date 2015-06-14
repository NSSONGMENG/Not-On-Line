//
//  SomeView.m
//  aaaDrawing
//
//  Created by songmeng on 15/5/8.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "SomeView.h"
#import "Define.h"
@interface SomeView ()
@property (nonatomic,strong) NSMutableArray * pointArray;
@property (nonatomic,copy)   NSString       * latestDataTime;
@end
@implementation SomeView

- (void)drawRect:(CGRect)rect {
    self.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    //获取最新数据时间
    self.latestDataTime = [[[[_dateArray lastObject] objectForKey:@"datatime"] componentsSeparatedByString:@" "] firstObject];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    #pragma  mark  -------------------画横纵轴--------------------
    CGContextMoveToPoint(context, kScreenWidth - 30,50);
    CGContextAddLineToPoint(context, 30, 50);
    CGContextAddLineToPoint(context, 30, self.frame.size.height - 50);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextStrokePath(context);
    
    #pragma  mark  -------------------画虚线--------------------
    for (int i = 0; i < (long)_numberOfDay+2 ;i ++){
        float y = kDateWidth*i + 50;
        
        if (i > 0) {
            //绘制横虚线
            CGFloat lengths[] = {2,2};
            CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
            
            CGContextMoveToPoint(context, 30, y);
            CGContextAddLineToPoint(context, kScreenWidth - 30, y);
            CGContextSetLineDash(context, 0, lengths, 2);
            CGContextStrokePath(context);
        }
        
        //日期获取
        NSDate * date = [NSDate dateWithTimeInterval:3600*24*i sinceDate:_firstDate];
        
        //日期格式化
        NSDateFormatter * formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"MM/dd"];
        
        //添加日期
        NSString * dateStr = [formater stringFromDate:date];
        UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, y - 10, 30, 20)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:8];
        lable.text = dateStr;
        lable.transform = CGAffineTransformMakeRotation(M_PI/2);
        [self addSubview:lable];
        
        //绘制折线
        //字典日期处理
        if (_dateArray.count > 0) {
            [formater setDateFormat:@"yyyy-MM-dd h:mm:ss"];
            
            NSDictionary * dic = [_dateArray firstObject];
            NSDate * day = [formater dateFromString:[dic objectForKey:@"datatime"]];
            [formater setDateFormat:@"MM/dd"];
            NSString * dayString = [formater stringFromDate:day];
            
            if ([lable.text isEqual:dayString]){
                [_dateArray removeObjectAtIndex:0];
                
                //绘制折线
                for (int j = 0; j < 8; j++) {
                    if ([[dic objectForKey:[NSString stringWithFormat:@"%d",j]] integerValue]>= 0) {
                        if (j == 0) {
                            CGContextMoveToPoint(context, 30, y);
                            //线条颜色
                            NSString * degre = [dic objectForKey:@"degree"];
                            if ([degre isEqual:@"轻"]) {
                                CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
                            }else if ([degre isEqual:@"中等"]){
                                CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
                            }else if ([degre isEqual:@"重"]){
                                CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
                            }else if ([degre isEqual:@"极重"]){
                                CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
                            }
                            
                            //实线
                            CGFloat length[] = {2,0};
                            CGContextSetLineDash(context, 0, length, 0);
                            CGContextSetLineWidth(context, 1.0);
                            
                            //将点添加至数组，方便对点进行绘制
                            [self.pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(30, y)]];
                        }else{
                            float x = (kScreenWidth - 70)/7*[[dic objectForKey:[NSString stringWithFormat:@"%d",j]] floatValue] + 30;
                            CGContextAddLineToPoint(context, x , y + kDateWidth/8*j);
                            
                            //将点添加至数组，方便对点进行绘制
                            [self.pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y + kDateWidth/8*j)]];
                        }
                        
                        if (j == 7){
                            CGContextStrokePath(context);
                        }
                    }
                }
                CGContextStrokePath(context);
            }
        }
    }
    
    //绘制竖虚线
    for (int i = 0; i < 8; i++) {
        float x = (kScreenWidth - 70)/7*i + 30;
        
        if (i > 0){
            CGContextMoveToPoint(context, x, 50);
            CGContextAddLineToPoint(context, x, self.frame.size.height - 50);
            CGFloat lengths[] = {2,2};
            CGContextSetLineDash(context, 0, lengths, 2);
            CGContextStrokePath(context);
        }
        
        UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(x - 10, 30, 20, 20)];
        lable.font = [UIFont systemFontOfSize:10];
        lable.text = [NSString stringWithFormat:@"%d级",i];
        lable.textAlignment = NSTextAlignmentLeft;
        lable.transform = CGAffineTransformMakeRotation(M_PI/2);
        [self addSubview:lable];
    }
    
    //描点
    for (NSValue * value in _pointArray) {
        CGContextFillRect(context, CGRectMake([value CGPointValue].x - 1.25 , [value CGPointValue].y - 1.25, 2.5, 2.5));
    }
    
    //颜色说明
    //线条颜色描述
    for (int i = 1; i < 5; i++){
        CGContextMoveToPoint(context, kScreenWidth - 15, 80 * i - 50);
        CGContextAddLineToPoint(context, kScreenWidth - 15, 80 * (i+0.6) - 50);
        UILabel * colorLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
        colorLable.center = CGPointMake(kScreenWidth - 15, 80 * (i + 1)-65);
        colorLable.textAlignment = NSTextAlignmentCenter;
        colorLable.transform = CGAffineTransformMakeRotation(M_PI/2);
        [colorLable setFont:[UIFont systemFontOfSize:14]];
        
        switch (i) {
            case 1:{
                CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
                colorLable.text = @"轻";
                colorLable.textColor = [UIColor greenColor];
                break;
            }
            case 2:{
                CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
                colorLable.text = @"中等";
                colorLable.textColor = [UIColor blueColor];
                break;
            }case 3:{
                CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
                colorLable.text = @"重";
                colorLable.textColor = [UIColor orangeColor];
                break;
            }
            default:{
                CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
                colorLable.text = @"极重";
                colorLable.textColor = [UIColor redColor];
                break;
            }
        }
        [self addSubview:colorLable];
        
        //实线
        CGFloat length[] = {2,0};
        CGContextSetLineDash(context, 0, length, 0);
        CGContextSetLineWidth(context, 1.0);
        CGContextStrokePath(context);
    }
    //最新数据时间
    UILabel * latestLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    latestLable.font = [UIFont systemFontOfSize:15];
    latestLable.textAlignment = NSTextAlignmentCenter;
    latestLable.text = [NSString stringWithFormat:@"最新数据时间：%@", _latestDataTime];
    latestLable.transform = CGAffineTransformMakeRotation(M_PI/2);
    latestLable.center = CGPointMake(kScreenWidth - 15, self.frame.size.height - 150);
    [self addSubview:latestLable];
}

- (NSMutableArray *)pointArray{
    if (_pointArray == nil) {
        _pointArray = [NSMutableArray array];
    }
    return _pointArray;
}







@end
