//
//  AddressListCell.m
//  PotatoWarning
//
//  Created by songmeng on 15/3/31.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "AddressListCell.h"
#import "Define.h"

@implementation AddressListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.addressName = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, kScreenWidth/2-15, 45)];
        _addressName.numberOfLines = 0;
        _addressName.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:_addressName];
        
        self.communication = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, 2, kScreenWidth/2-15, 45)];
        [self.contentView addSubview:_communication];
        _communication.numberOfLines = 0;
        _communication.lineBreakMode = NSLineBreakByWordWrapping;
        self.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:241.0/255.0 alpha:1];
    }
    return self;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
