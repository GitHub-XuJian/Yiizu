//
//  MyViewController.m
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MyViewController.h"
#import "MyHeaderVeiw.h"
#import "MyTableViewCell.h"
#import "MyCollectionViewController.h"
#import "MyActivitiesViewController.h"
#import "MyActivationCodeViewController.h"
#import "HelpCenterViewController.h"
#import "AboutUsViewController.h"
#import "ContactUsViewController.h"
#import "MyWalletViewController.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) MyHeaderVeiw *headerView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation MyViewController
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    // 隐藏导航条
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createDataArray];
    [self createTableView];
}
- (void)createDataArray
{
    self.dataArray = [NSMutableArray arrayWithObjects:@[@"我的激活码",@"我的钱包"],@[@"我的收藏",@"我的活动"],@[@"帮助中心",@"关于我们"], nil];
    self.imageArray = @[@[@"icon_activation",@"wallet"],@[@"icon_collect",@"icon_activity"],@[@"icon_help",@"icon_about"]];
    [self.tableView reloadData];
}
- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kSCREEN_WIDTH,kSCREEN_HEIGHT-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = kClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    
    self.headerView = [[MyHeaderVeiw alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 640/3)];
    self.tableView.tableHeaderView = self.headerView;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 135/3;
}
//设置组头和组尾部的颜色
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    //YourColor：
    view.tintColor = kClearColor;
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = kClearColor;
}
//分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
//设置每个区有多少行共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

// 构建tableView的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //必须用一个静态字符串
    static NSString *cellIdentifier = @"cell";
    
    // 判断是有空闲的cell,有进行重用，没有就创建一个
    MyTableViewCell  *cell  = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    return cell;
}


//响应点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"响应单击事件");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *viewController;
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    viewController = [[MyActivationCodeViewController alloc] init];
                    break;
                }
                case 1:{
                    viewController = [[MyWalletViewController alloc] init];

                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    viewController = [[MyCollectionViewController alloc] init];
                    break;
                }
                case 1:{
                    viewController = [[MyActivitiesViewController alloc] init];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 2:{
            switch (indexPath.row) {
                case 0:{
                    viewController = [[HelpCenterViewController alloc] init];
                    break;
                }
                case 1:{
                    viewController = [[AboutUsViewController alloc] init];
                    break;
                }
                
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    viewController.title = self.dataArray[indexPath.section][indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
    // 显示导航条
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
