//
//  MyViewController.m
//  PLBWaining
//
//  Created by songmeng on 15/4/1.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "MyViewController.h"
#import "RootTabBarController.h"
@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTabBarItem];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor greenColor]];
}

//添加TabBarItem方法
-(void)addTabBarItem{
    //创建button
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"Back-32"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];   //添加点击事件
    
    //创建BarButtonItem
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}
//button点击事件方法实现
-(void)click{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];   //返回列表页
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
