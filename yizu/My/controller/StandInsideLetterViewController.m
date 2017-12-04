//
//  StandInsideLetterViewController.m
//  yizu
//
//  Created by 徐健 on 2017/12/4.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "StandInsideLetterViewController.h"
#import "StandInsideLetterTableViewCell.h"
#import "StandInsideLetterDetailsViewController.h"

@interface StandInsideLetterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray  *dataArray;
@end

@implementation StandInsideLetterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createdata];
    [self createTableView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self createdata];
}
- (void)createdata
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/code/messageList",Main_Server];
    NSDictionary *dict = @{@"personid":@"171"};
    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        [SVProgressHUD dismiss];
        self.dataArray = responseObject;
        [self.tableView reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
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
    StandInsideLetterTableViewCell  *cell  = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[StandInsideLetterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.cellDict = self.dataArray[indexPath.row];
    return cell;
}


//响应点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"响应单击事件");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *cellDict = self.dataArray[indexPath.row];
    /**
     * 修改站内信状态
     */
    NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/code/messageStataApi",Main_Server];
    NSDictionary *dict = @{@"id":cellDict[@"id"]};
    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    StandInsideLetterDetailsViewController *detailsVC = [[StandInsideLetterDetailsViewController alloc] init];
    detailsVC.detailsDict = cellDict;
    detailsVC.title = @"恭喜";
    [self.navigationController pushViewController:detailsVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
