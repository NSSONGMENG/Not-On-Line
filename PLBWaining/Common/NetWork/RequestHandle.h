//
//  RequestHandle.h
//  Day-17-LessonNetWorkRequest
//
//  Created by songmeng on 15/3/25.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RequestHandle;

@protocol RequestHandleDelegate <NSObject>
//请求成功
-(void)requestHandle:(RequestHandle *)requestHandle didSucceedWithData:(NSData *)data;
//请求失败
-(void)requestHandle:(RequestHandle *)requestHandle failWithError:(NSError *)error;
@end

@interface RequestHandle : NSObject

@property (nonatomic,assign)id<RequestHandleDelegate>delegate;
@property (nonatomic,retain)NSURLConnection * connection;

//初始化方法
-(id)initWithUrlString:(NSString *)urlString
       parameterString:(NSString *)parameterString
                method:(NSString *)method
              delegate:(id<RequestHandleDelegate>)delegate;
-(void)cancle;

@end
