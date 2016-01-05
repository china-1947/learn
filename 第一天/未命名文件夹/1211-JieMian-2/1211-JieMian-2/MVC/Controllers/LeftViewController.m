//
//  LeftViewController.m
//  1211-JieMian-2
//
//  Created by 千锋 on 15/12/13.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "LeftViewController.h"

#import "LeftMenuCell.h"

#import "LeftMenuModel.h"


@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView * _backGroundView;//背景视图
    
    UIView * _containerView;//容器视图
    
    UITableView * _tableView;//表格视图
    
    NSArray * _arrData;//数据源数组
    
    UIView *_headerView;//头视图
    
    UIView *_footerView;
    
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建视图
    [self createUI];
    
    //请求数据
    [self requestDataWithUrl:API_LEFT_MENU_URL];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//创建UI
-(void)createUI{

    //创建背景视图
    _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_SIZE.width, SCREEN_SIZE.height)];
    
    _backGroundView.alpha = 0.6;
    
    _backGroundView.backgroundColor = [UIColor blackColor];
    
    _backGroundView.userInteractionEnabled = YES;
    
    [self.view addSubview:_backGroundView];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundOnTap:)];
    
    [_backGroundView addGestureRecognizer:tapGesture];
    
    //创建表格视图
    
    _containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CONTAINER_LEFT_VC_WIDTH, SCREEN_SIZE.height)];
    
    _containerView.backgroundColor = [UIColor whiteColor];
    
    _containerView.alpha = 1.0;
    
    [self.view addSubview:_containerView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth(_containerView.frame), SCREEN_SIZE.height)];
    
    [_containerView addSubview:_tableView];
    
    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
}

#pragma  mark --请求数据

//请求数据
-(void)requestDataWithUrl:(NSString *)strUrl{
    
    NSURL * URL = [NSURL URLWithString:strUrl];
    //创建URL请求
    NSURLRequest * request = [NSURLRequest requestWithURL:URL];
    //请求单例session
    NSURLSession * session = [NSURLSession sharedSession];
    //创建sessionDataTask任务
    NSURLSessionDataTask * requestTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //请求数据成功  赋值
        _arrData = [LeftMenuModel parseJSONWithData:data];
        //赋值成功，回到主对列重新加载表格式图数据
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    }];
    
    //提交任务
    [requestTask resume];

}

#pragma mark --selector
-(void)backgroundOnTap:(UITapGestureRecognizer *)sender{
    
    //[_backGroundView removeFromSuperview];
    
    [self.view removeFromSuperview];
    
}
-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LeftMenuCell * cell = (id)[tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIImage * image = [[UIImage imageNamed:@"menu_identify_left"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    if (section == 0) {
        
        _headerView = [[UIView alloc]initWithFrame:tableView.frame];
        
        //_tableView.backgroundColor  = [UIColor blueColor];
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(_headerView.bounds) - 60,0, 140, 40)];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(label1.frame) - 35, CGRectGetMidY(label1.frame) - 2, 35, 5)];
        imageView.image = image;
        
        UIImageView * imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), CGRectGetMidY(label1.frame) - 2, 35, 5)];
        imageView2.image = image;
        
        imageView2.transform = CGAffineTransformMakeRotation(M_PI);
        
        [_headerView addSubview:imageView2];
        
        [_headerView addSubview:imageView];
        
        label1.text = @"为独立思考人群服务";
        
        label1.textAlignment = NSTextAlignmentCenter;
        
        label1.font = [UIFont systemFontOfSize:15];
        
        label1.textAlignment = NSTextAlignmentCenter;
        
        [_headerView addSubview:label1];
        
    }else if(section == 1){
        
        _headerView = [[UIView alloc]initWithFrame:tableView.frame];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(_headerView.bounds) - 40, 10, 100, 30)];
        
        label.text = @"战略合作";
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [_headerView addSubview:label];
        
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(label.frame) - 35, CGRectGetMidY(label.frame) - 2, 35, 5)];
        imageView.image = image;
        
        UIImageView * imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMidY(label.frame) - 2, 35, 5)];
        imageView2.image = image;
        
        imageView2.transform = CGAffineTransformMakeRotation(M_PI);
        
        [_headerView addSubview:imageView2];
        
        [_headerView addSubview:imageView];
    }
    
    _headerView.backgroundColor = [UIColor colorWithRed:0.77 green:0.77 blue:0.77 alpha:1];
    return _headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}

#pragma mark --UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 4;
    }else{
        return 1;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString * strReuse = @"CELL";
        
        LeftMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:strReuse];
        
        if (!cell) {
            
            cell = [[LeftMenuCell alloc]init];
            
        }
        if (_arrData.count != 0) {
            
            LeftMenuModel * model = _arrData[indexPath.row];
            
            cell.model = model;
        }
        
        return cell;
        
    }else {
        
        UITableViewCell * cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLREUSE"];
        
        if(!cell1){
            
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLREUSE"];
        }
        
        cell1.textLabel.text = @"若想参与战略合作，请联系我们……";
        
        cell1.textLabel.font = [UIFont systemFontOfSize:10];
        
        return cell1;
    
    }
    
    
    
}



@end















