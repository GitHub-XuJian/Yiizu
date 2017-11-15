//
//  MembersView.m
//  yizu
//
//  Created by 徐健 on 2017/11/9.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MembersView.h"
#import "MembersTableViewCell.h"
#import "MembersHeadView.h"

@interface MembersView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) MembersHeadView *headerView;

@end

@implementation MembersView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIView];
        [self createData];
    }
    return self;
}
- (void)createData
{
    self.dataArray = [NSMutableArray arrayWithObjects:
  @{@"title":@"VIP套餐",@"button":@1},
                      @{@"title":@"1个月58元",@"button":@0,@"money":@58,@"tian":@30},
  @{@"title":@"3个月68元",@"button":@0,@"money":@68,@"tian":@90},
  @{@"title":@"6个月128元",@"button":@0,@"money":@128,@"tian":@180},
  @{@"title":@"年费233元",@"button":@0,@"money":@233,@"tian":@365}, nil];
    [self.tableView reloadData];
}
- (void)reloadData{
    [self.headerView reloadData];
}
- (void)createUIView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kSCREEN_WIDTH,kSCREEN_HEIGHT-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = kClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.scrollEnabled = NO;
    [self addSubview:self.tableView];
    
    self.headerView = [[MembersHeadView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, (77+84)/3+164/2)];
    self.tableView.tableHeaderView = self.headerView;
}
//头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [[UIView alloc]init];
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 135/2;
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
    return 1;
}
//设置每个区有多少行共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

// 构建tableView的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //必须用一个静态字符串
    static NSString *cellIdentifier = @"cell";
    
    // 判断是有空闲的cell,有进行重用，没有就创建一个
    MembersTableViewCell  *cell  = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[MembersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellDict = self.dataArray[indexPath.row];
    return cell;
}


//响应点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"响应单击事件");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
