//
//  MyCollectionViewController.m
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionTableViewCell.h"
#import "MyCollectionModel.h"

@interface MyCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MyCollectionViewController
- (NSMutableArray *)dataArray{
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
- (void)createDataArray
{
    NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Mine/keepaw",Main_Server];
    NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey]};
    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject count] == 0) {
            jxt_showToastTitle(@"暂无数据", 1);
        }
        /**
         * 结束刷新
         */
        [self.tableView.mj_header endRefreshing];
        for (NSDictionary *dict in responseObject) {
            MyCollectionModel *model = [[MyCollectionModel alloc] init];
            model.iconImage = [NSString stringWithFormat:@"%@public/%@",Main_ServerImage,dict[@"icon"]];
            model.nameStr = dict[@"chambername"];
            model.addressStr = [NSString stringWithFormat:@"!%@|点赞总数:%@",dict[@"city_id"],dict[@"keep"]];
            model.timeStr = [EncapsulationMethod timeStrWithTimeStamp:dict[@"keeptime"]];
            [self.dataArray addObject:model];
            [self.tableView reloadData];

        }
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
    
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
}
- (void)refresh
{
    [self.dataArray removeAllObjects];
    [self createDataArray];
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 135/2;
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
- (MyCollectionTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //必须用一个静态字符串
    static NSString *cellIdentifier = @"MyCollectionTableViewCell";
    
    // 判断是有空闲的cell,有进行重用，没有就创建一个
    MyCollectionTableViewCell  *cell  = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[MyCollectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    MyCollectionModel *model = self.dataArray[indexPath.row];
    [cell initWithMyCollectionModel:model];
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
