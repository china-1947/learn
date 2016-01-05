//
//  SlideViewController.m
//  1211-JieMian-2
//
//  Created by 千锋 on 15/12/13.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "SlideViewController.h"
#import "CollectionViewImageModel.h"
#import "SlideCollectionViewCell.h"


@interface SlideViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView * _collectionView;//集合视图
    NSArray * _arrData;//数据源数组
}

@end

@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = CGRectMake(0, HEADER_HEIGHT + 30, SCREEN_SIZE.width, SCREEN_SIZE.height - HEADER_HEIGHT - 30);
    
    [self requestData];
    
    [self createUI];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createUI{
    //创建collectionView 的管理类
    UICollectionViewFlowLayout * flowLayOut = [[UICollectionViewFlowLayout alloc]init];
    //初始化collectionView
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayOut];
    _collectionView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    [self.view addSubview:_collectionView];
    
    NSLog(@"_collectionView:%@",NSStringFromCGRect(_collectionView.frame));
    
    //_collectionView.backgroundColor = [UIColor purpleColor];
    //设置数据源和代理
    _collectionView.dataSource = self;
    
    _collectionView.delegate = self;
    
    //设置collectionView管理类的属性
    
    //flowLayOut.itemSize = CGSizeMake(SCREEN_SIZE.width / 3 , SCREEN_SIZE.width / 3);
    //设置展现方向，水平或垂直
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //collectionView注册单元格类
    [_collectionView registerClass:[SlideCollectionViewCell class] forCellWithReuseIdentifier:@"MyCell"];
    
}

//请求数据
-(void)requestData{
    
        NSDictionary * dict1 = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:API_CATEGORY_URL] options:NSDataReadingMappedIfSafe error:nil] options:NSJSONReadingMutableContainers error:nil];
        _arrData = [CollectionViewImageModel parseWithJSON:dict1];
}

#pragma mark --collectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _arrData.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SlideCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    
    if (indexPath.row < _arrData.count) {
        cell.model = _arrData[indexPath.row];
    }
    return cell;
}

#pragma mark --collectionViewDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(SCREEN_SIZE.width / 3 - 10, (SCREEN_SIZE.width / 3 - 10));
    
}


@end















