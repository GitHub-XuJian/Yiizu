//
//  MyActivitiesViewController.m
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MyActivitiesViewController.h"
#import "MyActivitiesTableViewCell.h"
@interface MyActivitiesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView     *tableView;

@end

@implementation MyActivitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createTableView];
}
- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,kSCREEN_WIDTH,kSCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = kClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

//分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//设置每个区有多少行共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

// 构建tableView的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //必须用一个静态字符串
    static NSString *cellIdentifier = @"cell";
    
    // 判断是有空闲的cell,有进行重用，没有就创建一个
    MyActivitiesTableViewCell  *cell  = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[MyActivitiesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.iconImage = [UIImage imageNamed:@"CN"];
    cell.nameStr = @"支付宝商家减免活动";
    cell.addressStr = @"大家来看数据都IE家啦几点啦看时间卡数据都上拉控件打脸萨控件啊蓝思科技上课";
    cell.timeStr = @"2017-7-15";
    cell.stateStr = @"进行中";
    return cell;
}


//响应点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"响应单击事件");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
