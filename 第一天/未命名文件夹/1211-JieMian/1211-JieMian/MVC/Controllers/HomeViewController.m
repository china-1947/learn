//
//  HomeViewController.m
//  1211-JieMian
//
//  Created by 千锋 on 15/12/11.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UIScrollViewDelegate>
{
    NSArray * _arrTitle;//主题名标题数组
    
    UIScrollView * _titleScrollView;//标题滚动视图
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _arrTitle = @[@"首页",@"天下",@"中国",@"娱乐",@"体育",@"时尚",@"旅游",@"科技",@"瘾擎",@"万间"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --CreateUI

-(void)createUI{
    
//    //自定义Navi
//    UINavigationItem * naviItem = self.navigationItem;
//    
//    UIBarButtonItem  * barItemLeft = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStyleDone target:self action:@selector(barItemLeftClicked:)];
//    
//    naviItem.leftBarButtonItem = barItemLeft;
//    
//    UIBarButtonItem * barItemRight = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu_head"] style:UIBarButtonItemStylePlain target:self action:@selector(barItemRightClicked:)];
//    
//    naviItem.rightBarButtonItem = barItemRight;
    
    
    //创建ScrollView
    
    _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, CGRectGetWidth(self.view.frame), 30)];
    
    [self.view addSubview:_titleScrollView];
    
    _titleScrollView.delegate = self;
    
    _titleScrollView.contentSize = CGSizeMake( TITLE_BUTTON_WIDTH * _arrTitle.count, 30);
    
    _titleScrollView.scrollEnabled = YES;
    
    _titleScrollView.userInteractionEnabled = YES;
    
    for (int index  = 0; index < _arrTitle.count; index ++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [_titleScrollView addSubview:btn];
        
        btn.frame = CGRectMake(index * TITLE_BUTTON_WIDTH, 0, TITLE_BUTTON_WIDTH, CGRectGetHeight(_titleScrollView.frame));
        
        [btn setTitle:_arrTitle[index] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
        
        btn.tag = TITLE_BUTTON_BEGIN_TAG + index;
    }
    
}
#pragma mark -- selector

//标题按钮按钮点击
-(void)btnClicked:(UIButton *)sender{
    
    NSLog(@"Sender:%ld",sender.tag);
    
}

-(void)barItemLeftClicked:(UIBarButtonItem *)sender{

}

-(void)barItemRightClicked:(UIBarButtonItem *)sender{

}

@end
