//
//  NewsModel.h
//  1211-JieMian-2
//
//  Created by 千锋 on 15/12/15.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, copy) NSString *hit;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *c_image;

@property (nonatomic, strong) NSArray *author_list;

@property (nonatomic, copy) NSString *headline;

@property (nonatomic, copy) NSString *published;

@property (nonatomic, copy) NSString *z_image;

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, copy) NSString *cl_image;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *s_image;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *o_image;

@property (nonatomic, copy) NSString *image_path;

@property (nonatomic, copy) NSString *publishtime;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *i_show_tpl;

@end
