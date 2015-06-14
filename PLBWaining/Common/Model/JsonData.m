//
//  JsonData.m
//  PotatoWarning
//
//  Created by songmeng on 15/3/30.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//
#pragma Mark JSON数据解析

#import "JsonData.h"
#import "AddressInfo.h"

@implementation JsonData

//使用移步get方式请求数据
+(void)setJsonData{
    //创建URL对象
    NSURL * url = [NSURL URLWithString:@"http://218.70.37.104:7000/mobile/mobile.aspx?type=97&user=yunnan&pass=yunnan&province=yunnan"];
    //创建数据请求对象
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    //使用代理方式请求数据
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark——connectionDataDelegate
//建立连接时触发
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"建立连接");
    self.mutableData = [NSMutableData data];
}

//获取数据时触发
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"获取数据");
    [self.mutableData appendData:data];
}

//完成数据获取时触发
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"完成下载");
    //数据处理
    NSArray * array = [NSJSONSerialization JSONObjectWithData:self.mutableData options:0 error:nil];
    
//    NSDictionary * dic = [array firstObject];     //获取包含type、sum、stu的字典
    
    NSMutableArray * arr = [NSMutableArray arrayWithArray:array];   //获取地址信息的字典组成的数组
    [arr removeObjectAtIndex:0];
    
    self.addressInfoArray = [NSMutableArray array];    //初始化保存AddressInfo对象的数组
    //循环遍历数组
    for (id obj in arr) {
        AddressInfo * addrInfo = [[AddressInfo alloc] init];
        [addrInfo setValuesForKeysWithDictionary:obj];
        [_addressInfoArray addObject:addrInfo];
        [addrInfo release];
    }
    
}

//请求失败时触发
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}


@end
