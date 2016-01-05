//
//  CollectionViewImageModel.h
//  1211-JieMian-2
//
//  Created by 千锋 on 15/12/14.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionViewImageModel : NSObject
/**
 *  名字/生成图像的网址
 */
@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString * imageURL;

+(NSArray *)parseWithJSON:(NSDictionary *)dict;

@end
