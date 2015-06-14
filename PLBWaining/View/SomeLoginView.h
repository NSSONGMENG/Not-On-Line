//
//  SomeLoginView.h
//  LoginView
//
//  Created by songmeng on 15/5/9.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SomeLoginDelegate <NSObject>

- (void)buttonClicked;

@end
@interface SomeLoginView : UIView <UITextFieldDelegate>
@property (nonatomic,copy) NSString * title;
@property (nonatomic,strong) UITextField * accountField;
@property (nonatomic,strong) UITextField * passwordField;
@property (nonatomic,assign) id<SomeLoginDelegate> delegate;


@end
