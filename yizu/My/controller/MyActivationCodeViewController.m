//
//  MyActivationCodeViewController.m
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MyActivationCodeViewController.h"
#import "MembershipActivationCodeViewController.h"
#import "MembersPayViewController.h"
#import "ActivationCodeInputViewController.h"
#import "ChartViewController.h"
@interface MyActivationCodeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MyActivationCodeViewController
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createTableView];
    [self createDataArray];
}
- (void)createDataArray{
    self.dataArray = [NSMutableArray arrayWithObjects:@"我的激活码",@"进度查询", nil];
}
- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,kSCREEN_WIDTH,kSCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = kClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    /**
     * 去掉多余横线
     */
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

    [self.view addSubview:self.tableView];
    
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

//分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//设置每个区有多少行共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

// 构建tableView的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //必须用一个静态字符串
    static NSString *cellIdentifier = @"cell";
    
    // 判断是有空闲的cell,有进行重用，没有就创建一个
    UITableViewCell  *cell  = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}


//响应点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"响应单击事件");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (IsLoginState) {
        UIViewController *viewController;
        switch (indexPath.row) {
            case 0:{
                viewController = [[MembershipActivationCodeViewController alloc] init];
                viewController.title = self.dataArray[indexPath.row];
                break;
            }
            case 1:{
                viewController = [[ChartViewController alloc] init];
                break;
            }
           
            default:
                break;
        }
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        LoginViewController *loginViewC = [[LoginViewController alloc] init];
        loginViewC.successfulBlock = ^{
            self.tabBarController.selectedIndex = 0;
        };
        loginViewC.failedBlock = ^{
            
        };
        [self presentViewController:loginViewC animated:YES completion:nil];
    }
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
