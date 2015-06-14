//
//  BasicInfoCell.m
//  PLBWaining
//
//  Created by songmeng on 15/4/27.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "BasicInfoCell.h"
#import "Define.h"

@implementation BasicInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, 45);
        
        self.nameLable.numberOfLines = 0;                           //换行
        self.nameLable.lineBreakMode = NSLineBreakByWordWrapping;   //换行模式
        [self addSubview:self.nameLable];
        
        self.contantLable.numberOfLines = 0;                            //换行
        self.contantLable.lineBreakMode = NSLineBreakByWordWrapping;    //换行模式
        [self addSubview:self.contantLable];
    }
    return self;
}

#pragma  mark  -------------------懒加载--------------------

- (UILabel *)nameLable{
    if (_nameLable == nil) {
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth/2-20, 45)];
    }
    return _nameLable;
}

- (UILabel *)contantLable{
    if (_contantLable == nil) {
        _contantLable = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-20, 0, kScreenWidth/2+20, 45)];
    }
    return _contantLable;
}

@end
