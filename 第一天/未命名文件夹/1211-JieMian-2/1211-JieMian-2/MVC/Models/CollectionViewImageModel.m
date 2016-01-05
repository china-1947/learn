//
//  CollectionViewImageModel.m
//  1211-JieMian-2
//
//  Created by 千锋 on 15/12/14.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "CollectionViewImageModel.h"


@implementation CollectionViewImageModel

+(NSArray *)parseWithJSON:(NSDictionary *)dict{
    
    NSMutableArray * arrayData = [NSMutableArray array];
    
    NSArray * arrResult = dict[@"result"];
    
    for (NSDictionary * dictTemp in arrResult) {
        
        CollectionViewImageModel * model = [[CollectionViewImageModel alloc]init];
        model.name = dictTemp[@"name"];
        
        model.imageURL = dictTemp[@"manage_img"];
        
        [arrayData addObject:model];
    }
    return [arrayData copy];
}


@end








