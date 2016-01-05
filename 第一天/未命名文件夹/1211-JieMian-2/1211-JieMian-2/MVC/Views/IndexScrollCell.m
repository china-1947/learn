//
//  IndexScrollCell.m
//  1211-JieMian-2
//
//  Created by 千锋 on 15/12/15.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "IndexScrollCell.h"
#import "IndexScrollImageModel.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@interface IndexScrollCell ()<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    UIPageControl * _pageControl;
    NSTimer * _timer;
    
}


@end
static NSInteger intIndexScrollStep = 1;
static NSInteger testInt = 0;
@implementation IndexScrollCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//创建timer
-(void)createTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(updateScroll) userInfo:nil repeats:YES];
    [_timer fire];
}

-(void)layoutSubviews{
//    NSArray * arrView = self.contentView.subviews;
//    for (UIView * viewTemp in arrView) {
//        
//        [viewTemp removeFromSuperview];
//    }
    [super layoutSubviews];
    testInt ++;
    if (!_scrollView) {
        if (!_timer) {
            [self createTimer];
        }
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        //设置scrollView 的contentSize
        if (_imageModelsArray.count == 0) {
            _scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
            _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_channel_item_default"]];
        }else{
            _scrollView.contentSize = CGSizeMake(self.frame.size.width * _imageModelsArray.count, self.frame.size.height);
        }
        _scrollView.delegate =self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        //添加图片
        for (int index = 0 ; index < _imageModelsArray.count; index ++) {
            IndexScrollImageModel * model = _imageModelsArray[index];
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(index * CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"channel_logo_default"]];
            
            UILabel * label = [[UILabel alloc]init];
            
            label.textColor = [UIColor whiteColor];
            //设置文字
            label.text = model.title;
            label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
            
            label.numberOfLines = 0;
            
            [imageView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageView.mas_left);
                make.bottom.equalTo(imageView.mas_bottom);
                make.width.equalTo(imageView.mas_width);
                int intHeight = imageView.frame.size.height / 3 - 10;
                make.height.equalTo(@[[NSNumber numberWithInt:intHeight]]);
            }];
            _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.frame) - 100, CGRectGetMaxY(self.frame) - 30, 70, 20)];
            
            [self addSubview:_pageControl];
            //分页指示器改变
            [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
            _pageControl.numberOfPages = _imageModelsArray.count;
            //_pageControl.currentPage = 5;
            _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
            [_scrollView addSubview:imageView];
        }
        
        [self.contentView addSubview:_scrollView];
    }
    NSLog(@"testInt:%ld",testInt);

}
//当pageControl改变时调用
-(void)pageChanged:(UIPageControl *)sender{
    CGPoint offsetPoint = CGPointMake(_pageControl.currentPage * _scrollView.frame.size.width, 0);
    [_scrollView setContentOffset:offsetPoint animated:YES];
    
}
//当scrollView 滑动完时会调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage =currentPage;
    
}

//timer selector
-(void)updateScroll{
    if (_pageControl.currentPage >= _imageModelsArray.count -1) {
        intIndexScrollStep = -intIndexScrollStep;
    }
    _pageControl.currentPage += intIndexScrollStep;
    
    //NSLog(@"_currentPage:%ld",_pageControl.currentPage);
    
    [self pageChanged:nil];
}
@end







