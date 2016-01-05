//
//  RightViewController.m
//  1211-JieMian-2
//
//  Created by 千锋 on 15/12/13.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "RightViewController.h"

#import "LoginViewController.h"

@interface RightViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView; //
    
    UIView * _baseBackgroundView;//透明视图层
    
    UIView * _backGroundView;//背景view
    
    NSArray * _arrTitle;//标题头数组
    
    NSArray * _arrImageName;//打头图片数组
}

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //self.view.frame = CGRectMake(0, HEADER_HEIGHT, SCREEN_SIZE.width, SCREEN_SIZE.height - HEADER_HEIGHT);
    
    _arrTitle = @[@"登陆/注册",@"消息",@"爆料",@"收藏",@"订阅",@"搜索",@"设置",@"无图模式",@"夜间模式"];
    
    _arrImageName = @[@"menu_icon_default_avatar@3x",@"menu_icon_msg@3x",@"icon_baoliao@3x",@"icon_favorite@3x",@"icon_subcribe@3x",@"menu_icon_search@3x",@"menu_icon_setting@3x"];
    [self createUI];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI{
    //透明图层，
    _baseBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    
    _baseBackgroundView.alpha = 0.1;
    
    _baseBackgroundView.backgroundColor = [UIColor whiteColor];
    
    _baseBackgroundView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundOnTap:)];
    
    [_baseBackgroundView addGestureRecognizer:tapGesture];
    
    [self.view addSubview:_baseBackgroundView];
    
    //黑色背景图层
    _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, HEADER_HEIGHT,SCREEN_SIZE.width, SCREEN_SIZE.height - HEADER_HEIGHT)];
    
    _backGroundView.alpha = 0.6;
    
    _backGroundView.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer * tapGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundOnTap:)];
    
    [_backGroundView addGestureRecognizer:tapGesture1];
    
    [self.view addSubview:_backGroundView];
    
    //创建表格视图
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame) - CONTAINER_LEFT_VC_WIDTH, CGRectGetMinY(_backGroundView.frame), CONTAINER_LEFT_VC_WIDTH, SCREEN_SIZE.height - HEADER_HEIGHT) ];
    
    [self.view  addSubview:_tableView];
    
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark --selector
-(void)backgroundOnTap:(UITapGestureRecognizer *)sender{
    
    [self.view removeFromSuperview];
    
}

-(void)switchChanged1:(UISwitch *)sender{
    
    NSLog(@"无图模式");

}

-(void)switchChanged2:(UISwitch *)sender{
    NSLog(@"夜间模式");
    
}
//表格视图
#pragma mark -- UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    if (indexPath.row < _arrTitle.count) {
        
        cell.textLabel.text = _arrTitle[indexPath.row];
        if (indexPath.row < 7) {
            UIImage * image = [[UIImage imageNamed:_arrImageName[indexPath.row]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            cell.imageView.image = image;
            if (indexPath.row != 0) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    if (indexPath.row == 7) {
        UISwitch * _switch = [[UISwitch alloc]initWithFrame:CGRectMake(200, 6, 0, 0)];
        [cell.contentView addSubview:_switch];
        [_switch addTarget:self action:@selector(switchChanged1:) forControlEvents:UIControlEventValueChanged];
    }else if(indexPath.row == 8){
        UISwitch * _switch = [[UISwitch alloc]initWithFrame:CGRectMake(200, 6, 0, 0)];
        [cell.contentView addSubview:_switch];
        [_switch addTarget:self action:@selector(switchChanged2:) forControlEvents:UIControlEventValueChanged];
        
    }
    
    //UITableViewCellSeparatorStyle;
    
    return cell;
    
}

#pragma mark --UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 80;
    }else{
        return 40;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            UIStoryboard * mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            LoginViewController * loginVC = [mainSB instantiateViewControllerWithIdentifier:@"loginIdentifier"];
            
            [self presentViewController:loginVC animated:YES completion:nil];
            
        }
            break;
            
        default:
            break;
    }
    
}

@end
