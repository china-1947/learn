//
//  LeftMenuCell.m
//  1211-JieMian-2
//
//  Created by 千锋 on 15/12/13.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "LeftMenuCell.h"

@implementation LeftMenuCell

{
    UIImageView * _imageView;
    
    UILabel *_colorLabel;
    
    UILabel * _titleLabel;
    
    UILabel * _sloganLabel;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//重写setter方法
-(void)setModel:(LeftMenuModel *)model{
    
    _model = model;
    
    [self createUI];
    
}


-(void)createUI{
    
    if (!_colorLabel) {
        _colorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 5, CGRectGetHeight(self.frame))];
        //设置颜色
        _colorLabel.backgroundColor = [self stringToColor:self.model.color];
    }
   
    [self.contentView addSubview:_colorLabel];
    
    if (!_imageView) {
        UIImage * image = [[UIImage imageNamed:self.model.icon]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_colorLabel.frame) + 25, CGRectGetMidY(_colorLabel.frame) - 15, 30, 30)];
        _imageView.image = image;
    }
    
    [self.contentView addSubview:_imageView];
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame) + 10, CGRectGetMidY(_imageView.frame)-10, CGRectGetMaxX(self.frame) - 15,15)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        //_titleLabel.text = self.model.title;
        //加下划线
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",self.model.title]];
        NSRange contentRange = {0,[content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        _titleLabel.attributedText = content;
    }
    [self.contentView addSubview:_titleLabel];
    
    if (!_sloganLabel) {
        
        _sloganLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame) + 5, CGRectGetWidth(_titleLabel.frame), 10)];
        _sloganLabel.adjustsFontSizeToFitWidth = YES;
        _sloganLabel.text = self.model.slogan;
        _sloganLabel.font = [UIFont systemFontOfSize:10];
        
    }
    [self.contentView addSubview:_sloganLabel];
    
    
}


-(UIColor *)stringToColor:(NSString *)strColor{
    
    if (!strColor || [strColor isEqualToString:@""]) {
        
        return [UIColor whiteColor];
    }
    unsigned red,green,blue;
    NSRange range;
    range.location =1;
    range.length = 2;
    [[NSScanner scannerWithString:[strColor substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    
    [[NSScanner scannerWithString:[strColor substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    
    [[NSScanner scannerWithString:[strColor substringWithRange:range]] scanHexInt:&blue];
    UIColor * color = [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:1.0];
    
    return color;

}

@end
