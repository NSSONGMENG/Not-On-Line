//
//  BightInfoViewController.m
//  PLBWaining
//
//  Created by songmeng on 15/4/1.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "BightInfoViewController.h"
#import "SomeView.h"
#import "Define.h"
#import "Singleton.h"
#import "WaittingView.h"

@interface BightInfoViewController ()

@property (nonatomic,assign) int sum;       //消息总数
@property (nonatomic,strong) NSMutableArray * infoArray;    //总消息数组
@property (nonatomic,strong) UIScrollView   * scrollView;
@property (nonatomic,strong) WaittingView   * waitView;     //等待界面
@end

@implementation BightInfoViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.view addSubview:self.waitView];
    
    //数据异步请求
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadData) object:nil];
    [thread start];
}

-(void)loadData{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBightInfoURL,[[Singleton basicInfoModel] name_id]]];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    NSError * error = nil;
    NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:@"数据获取失败"
                                                        delegate:self
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
        [alert show];
        
        [self.waitView removeFromSuperview];
    }else{
        _sum = [[[arr firstObject] objectForKey:@"sum"] intValue];
        _infoArray = [NSMutableArray arrayWithArray:arr];
        [_infoArray removeObjectAtIndex:0];
    }
    
    if (_sum > 0) {
        [self layoutDrawingView];
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:@"数据为空"
                                                        delegate:self
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
        [alert show];
    }
}

-(void)layoutDrawingView{
    if (_waitView) {
        [_waitView removeFromSuperview];
    }
    
    #pragma  mark  -------------------计算总天数--------------------
    NSString * firstDay = [[_infoArray firstObject] objectForKey:@"datatime"];
    NSString * lastDay = [[_infoArray lastObject] objectForKey:@"datatime"];
    
    NSDateFormatter * formater = [[NSDateFormatter alloc] init];
    [formater setTimeZone:[NSTimeZone localTimeZone]];  //设置时区
    [formater setDateFormat:@"yyyy-MM-dd h:mm:ss"];
    NSDate * firstDate = [formater dateFromString:firstDay];
    NSDate * lastDate = [formater dateFromString:lastDay];
    
    NSTimeInterval interval = [lastDate timeIntervalSinceDate:firstDate];
    NSInteger numOfDay = interval/3600/24;
    
    #pragma  mark  -------------------绘图相关--------------------
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(kWidth, (2*kScreenWidth > (kDateWidth*numOfDay + 150) ? 2*kScreenWidth : (kDateWidth*numOfDay + 200)));    //虚线间隔，即一天的单位，设定做小高度为2倍屏高
    
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    SomeView * aview = [[SomeView alloc] initWithFrame:CGRectMake(0, 50, _scrollView.contentSize.width, _scrollView.contentSize.height-50)];
    aview.backgroundColor = [UIColor whiteColor];
    aview.numberOfDay = numOfDay;
    aview.firstDate = firstDate;
    aview.dateArray = [NSMutableArray arrayWithArray:_infoArray];
    [_scrollView addSubview:aview];
    
    [self.view addSubview:_scrollView];
    [NSThread exit];
}

#pragma  mark  -------------------懒加载--------------------
- (WaittingView *)waitView{
    if (_waitView == nil) {
        _waitView = [[WaittingView alloc] initWithFrame:self.view.bounds];
    }
    return _waitView;
}


@end
