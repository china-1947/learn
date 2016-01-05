//
//  ContentViewController.m
//  1211-JieMian-2
//
//  Created by 千锋 on 15/12/13.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "ContentViewController.h"

#import "LeftViewController.h"

#import "RightViewController.h"

#import "HomeViewController.h"




@interface ContentViewController ()

{
    UIView * _currrentView;//当前显示的视图
    
    LeftViewController * _leftVC;//侧滑左视图
    
    RightViewController *_rightVC;//侧滑右视图
    
    HomeViewController *_homeVC;
    
    BOOL _leftSlideIsON ;//左侧打开
    
}

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建子视图
    [self getChildViewControllers];
    
    //创建UI
    [self createUI];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getChildViewControllers{
    
    _leftVC= [[LeftViewController alloc]init];
    
    _leftVC.view.frame = CGRectMake(-SCREEN_SIZE.width, 0, SCREEN_SIZE.width, SCREEN_SIZE.height);
    
    _rightVC = [[RightViewController alloc]init];
    
    _rightVC.view.frame = CGRectMake(SCREEN_SIZE.width, 0, SCREEN_SIZE.width, SCREEN_SIZE.height);
    
    _homeVC = [[HomeViewController alloc]init];
}

-(void)createUI{
    
    //设置当前是视图为homeVC
    _currrentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    
    _currrentView = _homeVC.view;
    
    [self.view addSubview:_currrentView];
    
    [self.view addSubview:_leftVC.view];
    
    //左侧按钮
    UINavigationItem * naviItem = self.navigationItem;
    
    UIImage * leftImage = [[UIImage imageNamed:@"menu"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClicked:)];
    
    naviItem.leftBarButtonItem = leftItem;
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];

    leftView.backgroundColor = [UIColor redColor];
    
    self.navigationItem.titleView = leftView;
}

//左侧按钮点击响应事件
-(void)leftItemClicked:(UIBarButtonItem *)sender{
    [UIView animateWithDuration:0.25 animations:^{
        _leftVC.view.frame = CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height);
    }];

    [self presentViewController:_leftVC animated:YES completion:nil];

}


@end
