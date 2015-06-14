//
//  MyPinAnnotationView.m
//  PLBWaining
//
//  Created by songmeng on 15/5/6.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//
#pragma  mark  -------------------自定义大头针--------------------
#import "MyPinAnnotationView.h"
#import <MapKit/MapKit.h>

@implementation MyPinAnnotationView

-(instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
        view.layer.cornerRadius = 2.5;
        view.backgroundColor = _color;
        [self addSubview:view];
    }
    return self;
}

@end
