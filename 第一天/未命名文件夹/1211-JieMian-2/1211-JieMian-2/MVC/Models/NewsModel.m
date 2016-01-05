//
//  NewsModel.m
//  1211-JieMian-2
//
//  Created by 千锋 on 15/12/15.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel


//重写KVC 的setter 和getter 方法
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}
-(id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}
@end

