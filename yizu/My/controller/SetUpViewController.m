//
//  SetUpViewController.m
//  yizu
//
//  Created by 徐健 on 2017/11/13.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "SetUpViewController.h"
#import "SetUpTableViewCell.h"

@interface SetUpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    
    [self createDataArray];
    [self createTableView];
    [self createBottomView];
}
- (void)createDataArray
{
    self.dataArray = [NSMutableArray arrayWithObjects:@[@"手机",@"QQ",@"微信"],@[@"密码管理",@"消息推送通知",@"清除缓存"], nil];
    [self.tableView reloadData];
}
- (void)createBottomView
{
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(0, kSCREEN_HEIGHT-60, kSCREEN_WIDTH, 60);
    bottomBtn.backgroundColor = [UIColor colorWithRed:0.40f green:0.40f blue:0.40f alpha:1.00f];
    [bottomBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(LogOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
}
- (void)LogOut
{
    if ([XSaverTool boolForKey:IsLogin]) {
        jxt_showAlertTwoButton(@"退出登录", @"", @"确定", ^(NSInteger buttonIndex) {
            [XSaverTool removeDataForKey:UserIDKey];
            [XSaverTool removeDataForKey:PhoneKey];
            [XSaverTool removeDataForKey:IsLogin];
            [XSaverTool removeDataForKey:UserIconImage];
            [XSaverTool removeDataForKey:VerificationCode];
            [XSaverTool removeDataForKey:VerificationCodeTime];
            [XSaverTool removeDataForKey:Statevip];
            [XSaverTool removeDataForKey:Nickname];
            [XSaverTool removeDataForKey:Personxq];
            [XSaverTool removeDataForKey:Password];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }, @"取消", ^(NSInteger buttonIndex) {
            
        });
    }else{
        jxt_showAlertTitle(@"请登录");
    }
    
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
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60 ;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"账号管理";
    }
    return @"";
}
// 返回组头部view的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
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
    SetUpTableViewCell  *cell  = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[SetUpTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier andIndexPath:indexPath];
    }
    cell.titleStr = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}


//响应点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"响应单击事件");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_dataArray[indexPath.section][indexPath.row] isEqualToString:@"清除缓存"]) {
        [[SDImageCache sharedImageCache] clearDisk];
        jxt_showAlertTitle(@"清除成功");
        [self.tableView reloadData];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
