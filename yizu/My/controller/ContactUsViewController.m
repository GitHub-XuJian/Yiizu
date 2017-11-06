//
//  ContactUsViewController.m
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ContactUsViewController.h"
#import "ProblemFeedbackViewController.h"
#import "ContactCSViewController.h"

@interface ContactUsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createTableView];
    [self createDataArray];
}
- (void)createTableView
{
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
- (void)createDataArray
{
    self.dataArray = @[@"问题反馈",@"联系客服"];
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 135/3;
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
    switch (indexPath.row) {
        case 0:{
            ProblemFeedbackViewController *pfVC = [[ProblemFeedbackViewController alloc] init];
            pfVC.title = self.dataArray[indexPath.row];
            [self.navigationController pushViewController:pfVC animated:YES];
            break;
        }
        case 1:{
            ContactCSViewController *pfVC = [[ContactCSViewController alloc] init];
            pfVC.title = self.dataArray[indexPath.row];
            [self.navigationController pushViewController:pfVC animated:YES];
            break;
        }
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
