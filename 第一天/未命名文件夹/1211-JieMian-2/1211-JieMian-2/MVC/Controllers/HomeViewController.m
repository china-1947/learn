//
//  HomeViewController.m
//  1211-JieMian
//
//  Created by 千锋 on 15/12/11.
//  Copyright (c) 2015年 千锋. All rights reserved.
//



#import "HomeViewController.h"
#import "RightViewController.h"
#import "LeftViewController.h"
#import "SlideViewController.h"
#import "Masonry.h"

//自定义视图
#import "IndexScrollCell.h"
#import "IndexScrollImageModel.h"



@interface HomeViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
//视图类
    UIView *_naviView;//自定义导航栏
    
    UIButton * _rightItem;
    
    UIButton *_leftItem;
    
    UILabel * _indicatorLabel;//滚动标题指示器
    
    UIView * _secondNavi;//次要导航栏
    
    NSArray * _arrTitle;//主题名标题数组
    
    UIScrollView * _titleScrollView;//标题滚动视图
    
    UIScrollView * _tableViewContainer;//主要内容表格视图容器视图
    
    LeftViewController * _leftVC;//侧滑左视图控制器
    
    RightViewController *_rightVC;//侧滑右视图控制器
    
    SlideViewController * _slideVC;//向下滑动视图
    
    BOOL _isSlideDown;//滑下滑动视图
    
    UIView * _slideView;//向下滑动视图
    
    UIView * _slideHeader;//设置向下滑动的标题条
    
    
//数据类
    NSArray * _arrScrollViewModels;//首页滚动视图数据
    
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //请求数据
    [self getAllData];
    //创建视图UI
    [self createUI];
    //[self colorAllViews];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --CreateUI
//着色所有控件
-(void)colorAllViews{
    
    _naviView.backgroundColor = [UIColor redColor];
    
    _titleScrollView.backgroundColor = [UIColor blueColor];
    
    _tableViewContainer.backgroundColor = [UIColor yellowColor];
    
}

-(void)createUI{
    
//    //自定义导航栏
    
    _naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame),44)];
 
    [self.view addSubview:_naviView];
    
    //自定义按钮菜单，登陆按钮
    
    UIImage * image1 = [[UIImage imageNamed:@"menu"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //菜单按钮
    _leftItem = [[UIButton alloc]initWithFrame:CGRectMake(0,10,TITLE_BUTTON_WIDTH, 30)];
    //添加导航栏按钮
    [_leftItem setImage:image1 forState:UIControlStateNormal];
    
    [_leftItem addTarget:self action:@selector(leftItemClicked:) forControlEvents:UIControlEventTouchDown];
    
    [_naviView addSubview:_leftItem];
    
    //个人中心按钮
    UIImage * image2 = [[UIImage imageNamed:@"menu_head"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    _rightItem = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_naviView.frame) - TITLE_BUTTON_WIDTH, 10, TITLE_BUTTON_WIDTH, 30)];
    
    [_rightItem addTarget:self action:@selector(rightItemClicked:) forControlEvents:UIControlEventTouchDown];
    
    [_rightItem setImage:image2 forState:UIControlStateNormal];
    
    [_naviView addSubview:_rightItem];
    //创建中心图画
    
    UIImage * iamge = [[UIImage imageNamed:@"top_logo"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImageView * centerImageView = [[UIImageView alloc]init];
    centerImageView.frame = CGRectMake(CGRectGetMidX(_naviView.frame) - 40,2 ,TITLE_BUTTON_WIDTH + 15, 40);
    
    centerImageView.image = iamge;
    
    //centerImageView.center = _naviView.center;
    
    [_naviView addSubview:centerImageView];
    
#pragma mark --创建次级标题导航条
    
    //创建次级导航条
    _secondNavi = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_naviView.frame), SCREEN_SIZE.width, 30)];
    [self.view addSubview:_secondNavi];
    
    //创建标题ScrollView
    
    _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width - 40, 30)];
    
    [_secondNavi addSubview:_titleScrollView];
    
    //_titleScrollView.layer.borderWidth = 1;
    
    _titleScrollView.layer.borderColor = [UIColor grayColor].CGColor;
    
    _titleScrollView.delegate = self;
    
    _titleScrollView.tag = TITLE_SCROLL_VIEW_TAG;
    
    _titleScrollView.contentSize = CGSizeMake( TITLE_BUTTON_WIDTH * _arrTitle.count, 30);
    
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    
    _titleScrollView.bounces = NO;
    
    for (int index  = 0; index < _arrTitle.count; index ++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [_titleScrollView addSubview:btn];
        
        btn.frame = CGRectMake(index * TITLE_BUTTON_WIDTH, 0, TITLE_BUTTON_WIDTH, CGRectGetHeight(_titleScrollView.frame));
        
        [btn setTitle:_arrTitle[index] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
        
        btn.tag = TITLE_BUTTON_BEGIN_TAG + index;
        
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
    //创建下滑触发按钮
    UIButton * buttonSlide = [UIButton buttonWithType:UIButtonTypeSystem];
    
    buttonSlide.frame = CGRectMake(CGRectGetMaxX(_titleScrollView.frame) + 5, 0, 25, 25);
    [_secondNavi addSubview:buttonSlide];
    
    [buttonSlide setBackgroundImage:[UIImage imageNamed:@"arrow_setting@3x"] forState:UIControlStateNormal];
    
    [buttonSlide addTarget:self action:@selector(buttonSlideClicked:) forControlEvents:UIControlEventTouchDown];
    buttonSlide.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    //创建指示条
    
    _indicatorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 26, TITLE_BUTTON_WIDTH, 2)];
    _indicatorLabel.backgroundColor = [UIColor redColor];
    
    [_titleScrollView addSubview:_indicatorLabel];
    
    //创建主要内容滑动表格视图
    [self createTableView];

    
}

#pragma mark --主要内容滑动表格视图

-(void)createTableView{
    //创建表格容器
    _tableViewContainer = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_secondNavi.frame), SCREEN_SIZE.width,SCREEN_SIZE.height - 20 - CGRectGetHeight(_naviView.frame) - CGRectGetHeight(_secondNavi.frame))];
    _tableViewContainer.tag = TABLE_CONTAINER_TAG;
    
    [self.view addSubview:_tableViewContainer];
    
    _tableViewContainer.pagingEnabled = YES;
    
    _tableViewContainer.showsHorizontalScrollIndicator = NO;
    
    _tableViewContainer.delegate = self;
    
    _tableViewContainer.contentSize = CGSizeMake(SCREEN_SIZE.width * _arrTitle.count, CGRectGetHeight(_tableViewContainer.frame));
    
    for (int ndex = 0; ndex < _arrTitle.count; ndex ++) {
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(ndex * SCREEN_SIZE.width, 0, SCREEN_SIZE.width,CGRectGetHeight(_tableViewContainer.frame))];
        
        
        tableView.tag = TABLE_BEGIN_TAG + ndex;
        
        tableView.dataSource = self;
        
        tableView.delegate = self;
        
        [_tableViewContainer addSubview:tableView];
        
    }
    
}


#pragma mark --请求数据

-(void)getAllData{
    //初始化所有滑动标题数组
    _arrTitle = @[@"首页",@"天下",@"中国",@"娱乐",@"体育",@"时尚",@"旅游",@"科技",@"瘾擎",@"万间"];

    //请求首页滑动图片视图数据
    NSURL * scrollViewURL = [NSURL URLWithString:API_INDEX_NEWS_URL];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * task = [session dataTaskWithURL:scrollViewURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        _arrScrollViewModels = [IndexScrollImageModel parseWithJSON:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableView * tableView = (id)[self.view viewWithTag:TABLE_BEGIN_TAG];
            [tableView reloadData];
        });
        
    }];
    [task resume];
    
}


#pragma mark -- UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath   *)indexPath{
    //
    if (tableView.tag == TABLE_BEGIN_TAG) {
        
        if (indexPath.section == 0 && indexPath.row == 0 ) {
            
            return 210;
            
        }else{
            
            return 200;
        }
    }else{
        
        
        return 200;
    }
    
}


#pragma mark --UITableViewDataDelegate

//返回多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == TABLE_BEGIN_TAG) {
        
        return 2;
        
    }else{
        return 1;
    }
    
    
}
//返回多少行，一组中
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == TABLE_BEGIN_TAG) {
        
        return 10;
    }else{
        return 20;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cellComon = [[UITableViewCell alloc]init];
    
    //首页表格视图
    if (tableView.tag == TABLE_BEGIN_TAG) {
        static NSString * strReuseHome = @"myHomeCell";
        static NSString * strReuseHome1 = @"homeCell";
        //首页第一组第一个单元格
        if ( indexPath.section == 0 && indexPath.row == 0)
        {
            IndexScrollCell * cellScroll = [tableView dequeueReusableCellWithIdentifier:strReuseHome];
            if (!cellScroll) {
                cellScroll = [[IndexScrollCell alloc]init];
            }
            cellScroll.imageModelsArray = _arrScrollViewModels;
            return cellScroll;
        }else{
        //首页其他组其他单元格
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strReuseHome];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strReuseHome1];
            }
            cell.textLabel.text = @"你好，世界!你好，世界!你好，世界!你好，世界!你好，世界!你好，世界!你好，世界!你好，世界!你好，世界!";
            return cell;
        }
    }
    
    cellComon.textLabel.text = @"hello Wolrd!";
    
    return cellComon;
}


#pragma mark -- scrollViewDelegate

//停止滑动调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //当前滑动视图的偏移量
    CGPoint pointOffset = scrollView.contentOffset;
    //偏移页数
    NSInteger offsetPage = pointOffset.x / SCREEN_SIZE.width;
    //滑动tableContainer中的视图修改更新
    if (scrollView.tag == TABLE_CONTAINER_TAG) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect indicatorRect =_indicatorLabel.frame;
            indicatorRect.origin.x = offsetPage * TITLE_BUTTON_WIDTH;
            _indicatorLabel.frame = indicatorRect;
            UIButton *btn = (id)[self.view viewWithTag:TITLE_BUTTON_BEGIN_TAG + offsetPage];
            //所有按钮变灰色
            //当前按钮变红色
            for (int index = 0; index < _arrTitle.count; index ++) {
                UIButton * btn = (id)[self.view viewWithTag:index + TITLE_BUTTON_BEGIN_TAG];
                
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                
            }
            //当前按钮变红色
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }];
    }
    
}

#pragma mark -- selector
//菜单按钮点击响应
//打开左侧滑动视图
-(void)leftItemClicked:(UIButton *)sender{
    
    _leftVC = [[LeftViewController alloc]init];

    [self.view addSubview:_leftVC.view];
    
}

-(void)rightItemClicked:(UIButton *)sender{
    
    _rightVC = [[RightViewController alloc]init];
    
    [self.view addSubview:_rightVC.view];
}
-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
}
//打开下滑视图响应
#pragma mark --向下滑视图
-(void)buttonSlideClicked:(UIButton *)sender{
    if (_isSlideDown == NO) {
        sender.transform = CGAffineTransformRotate(sender.transform, -M_PI);
        _isSlideDown = YES;
        
        _slideHeader = [[UIView alloc]initWithFrame:_titleScrollView.frame];
        _slideHeader.backgroundColor = [UIColor orangeColor];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 5,80,20)];
        
        label.text = @"我的频道";
        
        label.font = [UIFont systemFontOfSize:16];
        [_slideHeader addSubview:label];
        
        [_secondNavi addSubview:_slideHeader];
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 5 , CGRectGetMidY(label.frame) - 5,120,20)];
        
        label1.text = @"长按频道可拖动排序";
        
        label1.textColor = [UIColor lightGrayColor];
        
        label1.font = [UIFont systemFontOfSize:12];
        
        [_slideHeader addSubview:label1];
        
        _slideVC = [[SlideViewController alloc]init];
        
        [self.view addSubview:_slideVC.view];
        
    }else{
        sender.transform = CGAffineTransformRotate(sender.transform, M_PI);
        _isSlideDown = NO;
        [_slideHeader removeFromSuperview];
        if (_slideVC.view != nil) {
            [_slideVC.view removeFromSuperview];
        }
    }
    
}

//标题按钮按钮点击
-(void)btnClicked:(UIButton *)sender{
    //所有按钮变灰色
    //当前按钮变红色
    for (int index = 0; index < _arrTitle.count; index ++) {
        UIButton * btn = (id)[self.view viewWithTag:index + TITLE_BUTTON_BEGIN_TAG];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGFloat newX = sender.center.x;
        
        CGRect rect = _indicatorLabel.frame;
        
        rect.origin.x = newX - TITLE_BUTTON_WIDTH / 2;
        
        _indicatorLabel.frame = rect;
    }];
    
    //当点击按钮时，tableViewContainer 的视图offset 的设置
    
    CGPoint pointOffset = CGPointMake((sender.tag - TITLE_BUTTON_BEGIN_TAG) * SCREEN_SIZE.width, 0);
    
    [_tableViewContainer setContentOffset:pointOffset animated:YES];
    
}

@end

