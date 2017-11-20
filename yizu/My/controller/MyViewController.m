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
#import "PersonalInformationViewController.h"
#import "SetUpViewController.h"
#import "HomeViewController.h"


@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource,MyHeaderVeiwDelegate>
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
    [self navigationBarHidden:YES];
    [self.headerView reloadData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createDataArray];
    [self createTableView];
}
- (void)createDataArray
{
    self.dataArray = [NSMutableArray arrayWithObjects:@[@"我的卡券",@"我的钱包"],@[@"我的收藏",@"我的活动"],@[@"帮助中心",@"关于我们"], nil];
    self.imageArray = @[@[@"icon_activation",@"wallet"],@[@"icon_collect",@"icon_activity"],@[@"icon_help",@"icon_about"]];
    [self.tableView reloadData];
}
- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20,kSCREEN_WIDTH,kSCREEN_HEIGHT-70) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = kClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    
    self.headerView = [[MyHeaderVeiw alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 640/3)];
    self.headerView.delegate = self;
    self.tableView.tableHeaderView = self.headerView;
}
- (void)clickButton:(UIButton *)button
{
    if (button.tag == 111111) {
        if ([XSaverTool boolForKey:IsLogin]) {
            [self navigationBarHidden:NO];

            SetUpViewController *setUpVC = [[SetUpViewController alloc] init];
            setUpVC.title = @"设置";
            [self.navigationController pushViewController:setUpVC animated:YES];
        }else{
            jxt_showAlertTitle(@"请登录");
        }
        
    }else{
        [self navigationBarHidden:NO];

        if ([XSaverTool boolForKey:IsLogin]) {
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            
            PersonalInformationViewController *piVC = [[PersonalInformationViewController alloc] init];
            piVC.title = @"个人信息";
            [self.navigationController pushViewController:piVC animated:YES];
        }else{
            LoginViewController *loginViewC = [[LoginViewController alloc] init];
            loginViewC.successfulBlock = ^{
                self.tabBarController.selectedIndex = 0;
                [[AppDelegate shareDelegate] tabbarSelectedWithIndex:0];
            };
            loginViewC.failedBlock = ^{
                
            };
            [self presentViewController:loginViewC animated:YES completion:nil];
            
        }
    }
   
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
    return cell;
}


//响应点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"响应单击事件");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self navigationBarHidden:NO];

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
    
}
- (void)navigationBarHidden:(BOOL)isHidden
{
    // 显示导航条
    [self.navigationController setNavigationBarHidden:isHidden animated:NO];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    // 显示导航条
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
