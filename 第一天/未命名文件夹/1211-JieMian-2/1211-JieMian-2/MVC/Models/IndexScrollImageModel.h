//
//  IndexScrollImageModel.h
//  1211-JieMian-2
//
//  Created by 千锋 on 15/12/15.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndexScrollImageModel : NSObject

@property(nonatomic,copy)NSString * imageUrl;

@property(nonatomic,copy)NSString * title;

+(NSArray *)parseWithJSON:(NSData *)data;

@end
