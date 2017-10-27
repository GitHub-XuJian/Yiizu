//
//  HelpCenterViewController.m
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HelpCenterViewController.h"

@interface HelpCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation HelpCenterViewController
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchIcon"]];
        _imageView.bounds = CGRectMake(0, 0, 20, 20);
        _imageView.center = CGPointMake((kSCREEN_WIDTH-63/3*2)/2, 15);
    }
    return _imageView;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createSearchView];
    [self createTableView];
    [self createDataArray];

}
- (void)createDataArray
{
    self.dataArray = [NSMutableArray arrayWithObjects:@"常见问题",@"如何兑换激活码",@"道具购买后无法显示",@"收藏活动过期怎么办",@"使用依足有什么好处",@"使用指南",@"如何使用激活码",@"如何使用依足", nil];
    [self.tableView reloadData];
}
- (void)createSearchView
{
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(63/3, 74, kSCREEN_WIDTH-63/3*2, 30);
    textField.backgroundColor = [UIColor colorWithRed:0.86f green:0.86f blue:0.84f alpha:1.00f];
    textField.delegate = self;
    textField.leftViewMode = UITextFieldViewModeAlways;
    //设置圆角
    textField.layer.cornerRadius = 10;
    //将多余的部分切掉
    textField.layer.masksToBounds = YES;
    [self.view addSubview:textField];
    [textField addSubview:self.imageView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    textField.leftView = view;
}
- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 114,kSCREEN_WIDTH,kSCREEN_HEIGHT-114) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = kClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
   
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
        UILabel *lineview = [[UILabel alloc] init];
        lineview.backgroundColor = kColorLine;
        lineview.frame = CGRectMake(0, 135/3, kSCREEN_WIDTH, 0.5);
        [cell.contentView addSubview:lineview];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
//响应点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"响应单击事件");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^{
        self.imageView.center = CGPointMake(15, 15);
    } completion:^(BOOL finished) {

    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.center = CGPointMake((kSCREEN_WIDTH-63/3*2)/2, 15);
        } completion:^(BOOL finished) {
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
