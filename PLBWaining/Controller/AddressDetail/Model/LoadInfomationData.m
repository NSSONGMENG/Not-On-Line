//
//  LoadData.m
//  PLBWaining
//
//  Created by songmeng on 15/4/27.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "LoadInfomationData.h"
#import "RequestHandle.h"
#import "InfomationModel.h"
#import "Singleton.h"
#import "BasicInfoModel.h"

@interface LoadInfomationData()<RequestHandleDelegate>
@property (nonatomic,strong) RequestHandle      * handle;
@property (nonatomic,strong) InfomationModel   * infoModel;
@property (nonatomic,strong) NSString           * option;       //区分实时数据和历史数据和基本数据
@property (nonatomic,strong)BasicInfoModel * basicInfoModel;
@end
@implementation LoadInfomationData : NSObject 

-(void)requestDataByURLString:(NSString *)URLString option:(NSString *)option{
    self.handle = [[RequestHandle alloc]initWithUrlString:URLString parameterString:nil method:@"GET" delegate:self];
    self.option = option;
}

//请求成功
-(void)requestHandle:(RequestHandle *)requestHandle didSucceedWithData:(NSData *)data{
    if (data) {
        //数据解析
        NSError * error = nil;
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据处理出现异常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }else if ([self.option isEqual:@"basic"] && 1 == arr.count){
            //登录失败，arr数组长度为1，通知RootTabBarController重新登录
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loadBasicInfo" object:arr];
        }else{
            NSMutableArray * array = [NSMutableArray arrayWithArray:arr];
            NSDictionary * dic = [array lastObject];    //最后一个字典里保存的是所需要的info信息
            self.infoModel = [[InfomationModel alloc] init];
            [self.infoModel setValuesForKeysWithDictionary:dic];
            
            [Singleton setCurrentDic:dic];      //给单例中的字典赋值，tableView通过该字典的allKeys设定cell的数量
            if ([self.option isEqual:@"current"]) {
                [Singleton setCurrentInfo:self.infoModel];//给单例赋值
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loadcurrentinfo" object:nil];
            }else if ([self.option isEqual:@"history"]){
                [Singleton setHistoryInfo:self.infoModel];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loadhistoryinfo" object:nil];
            }else if ([self.option isEqual:@"basic"]){
                //基本信息处理
                
                NSMutableArray * dataArr = [NSMutableArray arrayWithArray:arr];
                
                //第一项不属于基本信息，所以删除第一项
                [dataArr removeObjectAtIndex:0];
                for (NSDictionary * dic in dataArr) {
                    BasicInfoModel * address = [[BasicInfoModel alloc] init];
                    [address setValuesForKeysWithDictionary:dic];
                    [self.basicInfoArray addObject:address];
                }
                [_basicInfoArray sortUsingSelector:@selector(compareByCommunication:)];
                
                #pragma  mark  -------------------通知--------------------
                /*
                 数据处理完成，给单例赋值，通知MapVC处理数据
                 */
                [Singleton setBasicInfoArray:_basicInfoArray];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loadBasicInfo" object:_basicInfoArray];

            }
        }
        
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据出现错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}
//请求失败
-(void)requestHandle:(RequestHandle *)requestHandle failWithError:(NSError *)error{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据获取失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

#pragma  mark  -------------------懒加载--------------------

- (NSMutableArray *)basicInfoArray{
    if (_basicInfoArray == nil) {
        _basicInfoArray = [NSMutableArray array];
    }
    return _basicInfoArray;
}

@end
