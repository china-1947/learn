//
//  SlideCollectionViewCell.m
//  1211-JieMian-2
//
//  Created by 千锋 on 15/12/14.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "SlideCollectionViewCell.h"
#import "UIImageView+WebCache.h"


@implementation SlideCollectionViewCell

{
    UIImageView * _imageView;
    
    UILabel * _textLabel;
}


-(void)setModel:(CollectionViewImageModel *)model{
    _model = model;
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 25)];
    }
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_model.imageURL] placeholderImage:[UIImage imageNamed:@"icon_channel_item_default"]];
    
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), CGRectGetWidth(_imageView.frame), 25)];
    }
    _textLabel.text =self.model.name;
    _textLabel.font = [UIFont systemFontOfSize:15];
    _textLabel.textColor = [UIColor grayColor];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_imageView];
    
    [self.contentView addSubview:_textLabel];
  
}


@end
