//
//  SomeLable.m
//  PLBWaining
//
//  Created by songmeng on 15/5/6.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "SomeLable.h"

@implementation SomeLable

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    float x = rect.origin.x + rect.size.width;
    float y = rect.origin.y;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, x, y);
    CGContextAddLineToPoint(context, x, y + rect.size.height);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextStrokePath(context);
}

@end
