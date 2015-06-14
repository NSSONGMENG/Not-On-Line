//
//  SomeLoginView.m
//  LoginView
//
//  Created by songmeng on 15/5/9.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "SomeLoginView.h"
#define kScreenHeight   [UIScreen mainScreen ].applicationFrame.size.height
#define kScreenWidth    [UIScreen mainScreen ].applicationFrame.size.width

@implementation SomeLoginView

- (void)drawRect:(CGRect)rect{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    //动画
    CAKeyframeAnimation * animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint point1 = CGPointMake(kScreenWidth/2, 0);
    CGPoint point2 = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    CGPoint point3 = CGPointMake(kScreenWidth/2, kScreenHeight/2+60);
    CGPoint point4 = CGPointMake(kScreenWidth/2, kScreenHeight/2+30);
    animation1.duration = 0.3f;
    animation1.values = @[[NSValue valueWithCGPoint:point1],
                         [NSValue valueWithCGPoint:point2],
                         [NSValue valueWithCGPoint:point3],
                         [NSValue valueWithCGPoint:point2],
                         [NSValue valueWithCGPoint:point4],
                         [NSValue valueWithCGPoint:point2],
                         ];
    animation1.calculationMode = kCAAnimationCubicPaced;
    [self.layer addAnimation:animation1 forKey:nil];
    
    self.frame = CGRectMake(0, 0, 260, 150);
    self.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    self.layer.cornerRadius = 10.0;
    self.layer.masksToBounds = YES;
    
    //标题
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 40)];
    titleLable.font = [UIFont systemFontOfSize:18];     //字号
    titleLable.textAlignment = NSTextAlignmentCenter;   //居中显示
    titleLable.text = self.title;
    [self addSubview:titleLable];
    
    //账号框
    _accountField = [[UITextField alloc] initWithFrame:CGRectMake(10, 41, 240, 30)];
    _accountField.placeholder = @"账号";
    _accountField.font = [UIFont systemFontOfSize:12];
    _accountField.keyboardType = UIKeyboardTypeASCIICapable;
    _accountField.backgroundColor = [UIColor whiteColor];
    _accountField.borderStyle = UITextBorderStyleRoundedRect;
    _accountField.delegate = self;
    _accountField.clearButtonMode = YES;
    if ([(NSString *)[user objectForKey:@"account"] length] > 0) {
        _accountField.text = (NSString *)[user objectForKey:@"account"];
    }
    [self addSubview:_accountField];
    
    //密码框
    _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(10, 75, 240, 30)];
    
    _passwordField.placeholder = @"密码";
    _passwordField.font = [UIFont systemFontOfSize:12];
    _passwordField.keyboardType = UIKeyboardTypeASCIICapable;
    _passwordField.secureTextEntry = YES;     //密码模式
    _passwordField.backgroundColor = [UIColor whiteColor];
    _passwordField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordField.delegate = self;
    _passwordField.clearButtonMode = YES;
    if ([(NSString *)[user objectForKey:@"password"] length] > 0) {
        _passwordField.text = [user objectForKey:@"password"];
    }
    [self addSubview:_passwordField];
    
    //画线
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextMoveToPoint(context, 0, 110);
//    CGContextAddLineToPoint(context, 260, 110);
//    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
//    CGContextStrokePath(context);
    
    //登陆
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 260, 40);
    button.center = CGPointMake(130, 130);
    [button setTitle:@"登陆" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)clicked{
    if ([self.delegate respondsToSelector:@selector(buttonClicked)]) {
        [self.delegate buttonClicked];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
