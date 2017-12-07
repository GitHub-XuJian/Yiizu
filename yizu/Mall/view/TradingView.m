//
//  TradingView.m
//  yizu
//
//  Created by 徐健 on 2017/11/9.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "TradingView.h"
#import "MallTransactionRecordsTableViewCell.h"
@interface TradingView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *imageArray;

@end
@implementation TradingView

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
    if (IsLoginState) {
        NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey]};
        NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Orderlist/orderlistApi",Main_Server];
        [SVProgressHUD showWithStatus:@"正在加载..."];
        [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            [SVProgressHUD dismiss];
            if ([responseObject count] == 0) {
//                jxt_showToastTitle(@"暂无数据", 1);
            }
            self.dataArray = responseObject;
            [self.tableView reloadData];
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        [self.tableView reloadData];
    }else{
        jxt_showAlertTwoButton(@"提示", @"请登录", @"确定", ^(NSInteger buttonIndex) {
            LoginViewController *loginViewC = [[LoginViewController alloc] init];
            loginViewC.successfulBlock = ^{
                [EncapsulationMethod viewController:self].tabBarController.selectedIndex = 0;
            };
            loginViewC.failedBlock = ^{
                
            };
            [[EncapsulationMethod viewController:self] presentViewController:loginViewC animated:YES completion:nil];
        }, @"取消", ^(NSInteger buttonIndex) {
            
        });
        
    }
}

- (void)createUIView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kSCREEN_WIDTH,kSCREEN_HEIGHT-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = kClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
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
    MallTransactionRecordsTableViewCell  *cell  = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[MallTransactionRecordsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.dictCell = self.dataArray[indexPath.row];
    return cell;
}


//响应点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"响应单击事件");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end
