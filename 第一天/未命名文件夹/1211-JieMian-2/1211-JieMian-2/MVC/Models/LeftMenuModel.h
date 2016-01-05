//
//  LeftMenuModel.h
//  1211-JieMian-2
//
//  Created by 千锋 on 15/12/13.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeftMenuModel : NSObject

@property(nonatomic,copy)NSString * color;
@property(nonatomic,copy)NSString * icon;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * slogan;

+(NSArray *)parseJSONWithData:(NSData *)data;
@end
