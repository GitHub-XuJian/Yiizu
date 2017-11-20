//
//  PasswordManagementViewController.m
//  yizu
//
//  Created by 徐健 on 2017/11/16.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "PasswordManagementViewController.h"
#import "SFValidationEmailViewController.h"
#import "ChangePasswordViewController.h"

@interface PasswordManagementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PasswordManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    
    [self createDataArray];
    [self createTableView];
}
- (void)createDataArray
{
    self.dataArray = [NSMutableArray arrayWithObjects:@"修改密码",@"找回密码", nil];
    [self.tableView reloadData];
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kSCREEN_WIDTH,kSCREEN_HEIGHT-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = kClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60 ;
}
//设置每个区有多少行共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

// 构建tableView的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //必须用一个静态字符串
    static NSString *cellIdentifier = @"cell";
    
    // 判断是有空闲的cell,有进行重用，没有就创建一个
    UITableViewCell  *cell  = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    UIView *lineView;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, kSCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = kColorLine;
        [cell addSubview:lineView];
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
            NSLog(@"修改密码");
            ChangePasswordViewController *cpVC = [[ChangePasswordViewController alloc] init];
            cpVC.title = @"修改密码";
            [self.navigationController pushViewController:cpVC animated:YES];
            break;
        }
        case 1:{
            NSLog(@"找回密码");
            SFValidationEmailViewController *validationVC = [[SFValidationEmailViewController alloc] init];
            validationVC.emailStr = [XSaverTool objectForKey:PhoneKey];
            validationVC.title = @"找回密码";
            validationVC.isValidation = NO;
            [self.navigationController pushViewController:validationVC animated:YES];
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
