//
//  LoginViewController.m
//  PLBWaining
//
//  Created by songmeng on 15/5/19.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "LoginViewController.h"
#import "SomeLoginView.h"
//#import "LoadBasicInfo.h"
#import "Define.h"
#import "LoadInfomationData.h"

@interface LoginViewController ()<SomeLoginDelegate>
@property (nonatomic,strong) SomeLoginView  * loginView;    //登录页面
@property (nonatomic,strong) UIImageView    * imageView;
@property (nonatomic,strong) NSUserDefaults * user;
@property (nonatomic,strong) UIImageView    * waittingView; //等待图片
@property (nonatomic,strong) LoadInfomationData  * loadData;
@property (nonatomic,strong) UIScrollView   * scrollView;
@property (nonatomic,strong) NSTimer        * timer;        //定时器
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBasicData:) name:@"loadBasicInfo" object:nil];
    [self login];
}

- (void)login{
    //加载引导图
    [self layoutScrollView];
    
    //登录窗口
    self.loginView = [[SomeLoginView alloc] init];
    
    _loginView.frame = self.view.bounds;
    _loginView.backgroundColor = [UIColor whiteColor];
    _loginView.title = @"请登陆";
    _loginView.delegate = self;
    
    [self.view addSubview:_loginView];
}

//加载背景图
- (void)layoutScrollView{
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imageView.image = [UIImage imageNamed:@"potato.png"];
    [self.view addSubview:_imageView];
    
}

#pragma  mark  -------------------login view代理方法--------------------
-(void)buttonClicked{
    _loginView.alpha = 0;
    //等待
    self.waittingView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    _waittingView.center = CGPointMake(kWidth/2, kHeight/2);
    _waittingView.image = [UIImage imageNamed:@"Waitting.png"];
    
    //判断用户名密码不许为空
    if (_loginView.accountField.text.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:@"用户名不能为空"
                                                        delegate:self
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
        [alert show];
    }else if (_loginView.passwordField.text.length == 0){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:@"密码不能为空"
                                                        delegate:self
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
        [alert show];
    }else{
        
        #pragma  mark  -------------------数据请求--------------------
        NSString  * append = [NSString stringWithFormat:@"&user=%@&pass=%@",self.loginView.accountField.text,self.loginView.passwordField.text];
//        [self.loadData requestBasicInfoWithURLString:[kBasicInfoURL stringByAppendingString:append]];
        [self.loadData requestDataByURLString:[kBasicInfoURL stringByAppendingString:append] option:@"basic"];
        
        [self.view addSubview:_waittingView];   //添加等待图片
        [self.timer timeInterval];              //启动定时器
    }
}

//数据请求成功回调方法
- (void)loadBasicData:(NSNotification *)notification{
    NSArray * arr = [notification object];
    if (arr.count < 2) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:@"用户名或密码有误"
                                                        delegate:self
                                               cancelButtonTitle:nil
                                               otherButtonTitles:@"确定",nil];
        [alert show];
        [self.waittingView removeFromSuperview];
        [self.timer fire];
    }else{
        //保存用户名和密码
        [self.user setObject:self.loginView.accountField.text forKey:@"account"];
        [self.user setObject:self.loginView.passwordField.text forKey:@"password"];
        
//        [_imageView removeFromSuperview];
//        [_loginView removeFromSuperview];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setSeletedAtIndex" object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma  mark  -------------------动画--------------------
- (void)animation{
    //添加动画
    [UIView animateKeyframesWithDuration:0.5f delay:1.0f options:0 animations:^{
        _scrollView.alpha = 0;
    } completion:^(BOOL finished) {
        [_scrollView removeFromSuperview];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    _loginView.alpha = 1;
}

- (void)repeatWaittingAnimation{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    self.waittingView.transform = CGAffineTransformRotate(self.waittingView.transform, M_PI/5);
    [UIView commitAnimations];
}

#pragma  mark  -------------------懒加载--------------------
- (NSUserDefaults *)user{
    if (_user == nil) {
        _user = [NSUserDefaults standardUserDefaults];
    }
    return _user;
}

- (LoadInfomationData *)loadData{
    if (_loadData == nil) {
        _loadData = [[LoadInfomationData alloc] init];
    }
    return _loadData;
}

- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(repeatWaittingAnimation) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
