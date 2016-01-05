//
//  LeftMenuModel.m
//  1211-JieMian-2
//
//  Created by 千锋 on 15/12/13.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "LeftMenuModel.h"

@implementation LeftMenuModel

+(NSArray *)parseJSONWithData:(NSData *)data{
    NSMutableArray * arrRS = [NSMutableArray array];
    NSError * error;
    NSDictionary * baseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"error:++++++++%@",error);
    }
    NSArray * dataArr = baseDict[@"result"][@"channel"];
    
    for (NSDictionary * dict in dataArr) {
        LeftMenuModel * model = [[LeftMenuModel alloc]init];
        model.color = dict[@"color"];
        NSDictionary * dictTemp = [dict[@"rows"] firstObject];
        model.icon = dictTemp[@"icon"];
        model.slogan = dictTemp[@"slogan"];
        model.title = dictTemp[@"title"];
        [arrRS addObject:model];
    }
    
    return [arrRS copy];
    
}
@end












