//
//  RequestHandle.m
//  Day-17-LessonNetWorkRequest
//
//  Created by songmeng on 15/3/25.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "RequestHandle.h"
@interface RequestHandle()<NSURLConnectionDataDelegate>
@property (nonatomic,strong)NSMutableData * data;   //数据储存
@end

@implementation RequestHandle

-(id)initWithUrlString:(NSString *)urlString
       parameterString:(NSString *)parameterString
                method:(NSString *)method
              delegate:(id<RequestHandleDelegate>)delegate{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        
        //根据method进行get或者post方式选择
        if([method isEqual:@"GET"]){
            [self requestByGETWithUrlString:(NSString *)urlString];     //get请求
        }else if([method isEqual:@"POST"]){
            [self requestByGETWithUrlString:(NSString *)urlString
                            parameterString:(NSString *)parameterString];    //post请求
        }
    }
    return self;
}

//GET请求
-(void)requestByGETWithUrlString:(NSString *)urlString{
    //编码创建URL对象
    NSURL * url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
   
    //创建请求对象
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    //链接请求数据
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

//POST请求
-(void)requestByGETWithUrlString:(NSString *)urlString
                 parameterString:(NSString *)parameterString{
    NSURL * url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //创建可变请求对象
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    
    //创建请求体
    NSString * parameter = [NSString stringWithFormat:@"%@",parameterString];
    
    //设置请求体
    NSData * parameterData = [parameter dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [request setHTTPBody:parameterData];
    [request setHTTPMethod:@"POST"];
    
    //连接请求数据
    [NSURLConnection connectionWithRequest:request delegate:self];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        NSDictionary * dic = [NS JSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSLog(@"%@",dic);
//    }];
}

-(void)cancle{
    [self.connection cancel];
}

#pragma mark —— 代理

//建立连接时触发
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.data = [NSMutableData data];
}

//传输数据时触发
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.data appendData:data];
}

//完成加载时触发
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //数据加载完成后通知代理读取数据
    if ([self.delegate respondsToSelector:@selector(requestHandle:didSucceedWithData:)]) {
        [self.delegate requestHandle:self didSucceedWithData:_data];
    }
}

//加载失败时触发
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(requestHandle:failWithError:)]) {
        [self.delegate requestHandle:self failWithError:error];
    }
}

//-(void)dealloc{
//    [_connection release];
//    [_data release];
//    [super dealloc];
//}

@end
