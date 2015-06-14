//
//  InfomationModel.m
//  PLBWaining
//
//  Created by songmeng on 15/4/27.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "InfomationModel.h"

@implementation InfomationModel

-(void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqual:@"qiya"]) {                                            //气压
        if ([value integerValue] < 0) {
            self.qiya = @"---";
        }else{
            self.qiya = [NSString stringWithFormat:@"%@",value];
        }
    }else if ([key isEqual:@"ludian"]){                                     //露点
        if ([value integerValue] < 0){
            self.ludian = @"---";
        }else{
            self.ludian = [NSString stringWithFormat:@"%.1f",[value doubleValue]];
        }
    }else if([key isEqual:@"zhengsanliang"]){                               //蒸散量
        if ([value integerValue] < 0) {
            self.zhengsanliang = @"---";
        }else{
            self.zhengsanliang = [NSString stringWithFormat:@"%@",value];
        }
    }else if ([key isEqual:@"fengsu"]){                                     //风速
        if ([value integerValue] < 0) {
            self.fengsu = @"---";
        }else{
            self.fengsu = [NSString stringWithFormat:@"%@",value];
        }
    }else if ([key isEqual:@"yuliang"]){                                    //雨量
        if ([value integerValue] < 0) {
            self.yuliang = @"---";
        }else{
            self.yuliang = [NSString stringWithFormat:@"%@",value];
        }
    }else if ([key isEqual:@"wendu"]){                                      //温度
        if ([value integerValue] < 0) {
            self.wendu = @"---";
        }else{
            self.wendu = [NSString stringWithFormat:@"%@",value];
        }
    }else if ([key isEqual:@"zuigaowendu"]){                                //最高温度
        if ([value integerValue] < 0) {
            self.zuigaowendu = @"---";
        }else{
            self.zuigaowendu = [NSString stringWithFormat:@"%@",value];
        }
    }else if ([key isEqual:@"zuidiwendu"]){                                 //最低温度
        if ([value integerValue] < 0) {
            self.zuidiwendu = @"---";
        }else{
            self.zuidiwendu = [NSString stringWithFormat:@"%@",value];
        }
    }else if ([key isEqual:@"shidu"]){                                      //湿度
        if ([value integerValue] < 0) {
            self.shidu = @"---";
        }else{
            self.shidu = [NSString stringWithFormat:@"%.1f",[value doubleValue]];
        }
    }else if([key isEqual:@"jidafengsu"]){                                  //极大风速
        if ([value integerValue] < 0) {
            self.jidafengsu = @"---";
        }else{
            self.jidafengsu = [NSString stringWithFormat:@"%.1f",[value doubleValue]];
        }
    }else if ([key isEqual:@"fengxiang"]){                                  //风向
        if ([value integerValue] < 0) {
            self.fengxiang = @"---";
        }else{
            self.fengxiang = [NSString stringWithFormat:@"%@",value];
        }
    }else if ([key isEqual:@"duiyingfengxiang"]){                           //对应风向
        if ([value integerValue] < 0) {
            self.duiyingfengxiang = @"---";
        }else{
            self.duiyingfengxiang = [NSString stringWithFormat:@"%@",value];
        }
    }else if ([key isEqual:@"taiyangfushe"]){                               //太阳辐射
        if ([value integerValue] < 0) {
            self.taiyangfushe = @"---";
        }else{
            self.taiyangfushe = [NSString stringWithFormat:@"%@",value];
        }
    }else if ([key isEqual:@"turangshidu"]){                                //土壤湿度
        if ([value integerValue] < 0) {
            self.turangshidu = @"---";
        }else{
            self.turangshidu = [NSString stringWithFormat:@"%@",value];
        }
    }else if ([key isEqual:@"turangwendu"]){                                //土壤温度
        if ([value integerValue] < 0) {
            self.turangwendu = @"---";
        }else{
            self.turangwendu = [NSString stringWithFormat:@"%@",value];
        }
    }else if ([key isEqual:@"ziwai"]){                                      //紫外
        if ([value integerValue] < 0) {
            self.ziwai = @"---";
        }else{
            self.ziwai = [NSString stringWithFormat:@"%@",value];
        }
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

-(NSString *)description{
    return [NSString stringWithFormat:@"name:%@  侵染:%@  最高温度：%@  最低温度：%@",_name,_qinran,_zuigaowendu,_zuidiwendu];
}
@end
