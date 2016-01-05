//
//  IndexScrollImageModel.m
//  1211-JieMian-2
//
//  Created by 千锋 on 15/12/15.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "IndexScrollImageModel.h"

@implementation IndexScrollImageModel

//通过类方法解析数据，返回模型数组
+(NSArray *)parseWithJSON:(NSData *)data{
    NSMutableArray * arrImageModels = [NSMutableArray array];
    NSDictionary * dictAll = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray * arrTemp = dictAll[@"result"][@"carousel"];
    for (NSDictionary * dict in arrTemp) {
        IndexScrollImageModel * model = [[IndexScrollImageModel alloc]init];
        model.imageUrl = dict[@"z_image"];
        model.title = dict[@"title"];
        [arrImageModels addObject:model];
    }
    return [arrImageModels copy];
}
@end

















