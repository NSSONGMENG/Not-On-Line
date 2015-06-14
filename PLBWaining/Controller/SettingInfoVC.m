//
//  SettingInfoVC.m
//  PLBWaining
//
//  Created by songmeng on 15/5/6.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "SettingInfoVC.h"
#import "Define.h"
@interface SettingInfoVC()
@property (nonatomic,strong) UIImageView * imageView;
@end
@implementation SettingInfoVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:241.0/255.0 alpha:1];
    
    UILabel * infoLable = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/2 - 150, kHeight/2 - 200, 300, 400)];
    infoLable.textAlignment = NSTextAlignmentLeft;
    infoLable.lineBreakMode = NSLineBreakByWordWrapping;
    infoLable.numberOfLines = 0;
    infoLable.textColor = [UIColor blackColor];
    infoLable.text = _info;
    
    [self.view addSubview:infoLable];
    
    if ([[_info substringToIndex:4] isEqual:@"联系方式"]){
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(kWidth/2+50, kHeight/2 - 52, 20, 20);
        [button setBackgroundImage:[UIImage imageNamed:@"call_number.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(callUs) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)callUs{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://010-84786221"]];
}

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    }
    return _imageView;
}

@end
