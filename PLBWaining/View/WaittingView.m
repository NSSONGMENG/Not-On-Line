//
//  WaittingView.m
//  testView
//
//  Created by songmeng on 15/4/17.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//
#pragma  mark  -------------------等待界面--------------------
#import "WaittingView.h"
#import "Define.h"
@interface WaittingView()
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UILabel     * infoLable;
@property (nonatomic,assign) double      angle;
@end

@implementation WaittingView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if ([super initWithFrame:frame]) {
        self.frame = [UIScreen mainScreen ].applicationFrame;
        
        self.imageView.image = [UIImage imageNamed:@"Waitting.png"];
        _imageView.center = CGPointMake((kScreenWidth-120)/2, (kScreenHeight-24)/2);
        [self addSubview:_imageView];
        
        self.infoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 24)];
        _infoLable.text = @"内容正在加载中...";
        _infoLable.textAlignment = NSTextAlignmentCenter;
        _infoLable.center = CGPointMake(kScreenWidth/2+24, (kScreenHeight-24)/2);
        [self addSubview:_infoLable];
        
        _angle = 1.0;
        [self startAnimation];
        
    }
    return self;
}

-(void) startAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    _imageView.transform = CGAffineTransformMakeRotation(self.angle * (M_PI / 12.0f));
    [UIView commitAnimations];
}

-(void)endAnimation
{
    self.angle += 1.0;
    [self startAnimation];
}

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    }
    return _imageView;
}

@end
