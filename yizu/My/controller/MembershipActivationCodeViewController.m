//
//  MembershipActivationCodeViewController.m
//  yizu
//
//  Created by 徐健 on 17/10/24.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MembershipActivationCodeViewController.h"
#import "MembershipActivationCodeView.h"
#import "MembershipActivationCodeTableViewCell.h"

@interface MembershipActivationCodeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_buttonStr;
}
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) MembershipActivationCodeView *macView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MembershipActivationCodeViewController
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
    [self createViewUI];
    [self createTableView];
    [self createDataArray:@"notShareApi"];
    
}
- (void)createDataArray:(NSString *)str
{
  
    NSString *urlStr =[NSString stringWithFormat:@"%@Mobile/Code/%@",Main_Server,str];
    NSDictionary *dict = @{@"personid":@"3"};
    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        self.dataArray = responseObject;
        [self.tableView reloadData];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
//    //随机数从这里边产生
//    NSMutableArray *startArray=[[NSMutableArray alloc] initWithObjects:@0,@1,@2,@3,@4,@5,@6,@7,@"1233123133",@"99231239",@"4dsfsfsdf453",@"1233123133",@"99231239",@"4dsfsfsdf453", nil];
//    //随机数产生结果
//    _dataArray=[[NSMutableArray alloc] initWithCapacity:0];
//    //随机数个数
//    NSInteger m=arc4random()%startArray.count;
//    for (int i=0; i<m; i++) {
//        int t=arc4random()%startArray.count;
//        _dataArray[i]=startArray[t];
//        startArray[t]=[startArray lastObject]; //为更好的乱序，故交换下位置
//        [startArray removeLastObject];
//    }
}
- (void)createViewUI
{
    _buttonStr = @"分享";
    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:@"未分享",@"已分享",@"已激活",@"可回购", nil];
    self.macView = [[MembershipActivationCodeView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, 50) andTitleArray:titleArray andClassBlock:^(UIButton *classBtn) {
        NSLog(@"%@",classBtn.titleLabel.text);
        _buttonStr = nil;
        switch (classBtn.tag) {
            case 0:{
                _buttonStr = @"分享";
                [self createDataArray:@"notShareApi"];

                break;
            }
            case 1:{
                _buttonStr = @"已分享";
                [self createDataArray:@"Share"];

                break;
            }
            case 2:{
                _buttonStr = @"";
                [self createDataArray:@"activate"];
                
                break;
            }
            case 3:{
                _buttonStr = @"回购";
                [self createDataArray:@"backCodeApi"];
                
                break;
            }
            default:
                break;
        }
    }];
    [self.view addSubview:self.macView];
    
}
- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.macView.y+self.macView.height+5,kSCREEN_WIDTH,kSCREEN_HEIGHT-self.macView.y-self.macView.height-5) style:UITableViewStylePlain];
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
    
    return kTableViewCell_HEIGHT;
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
    MembershipActivationCodeTableViewCell  *cell  = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[MembershipActivationCodeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.dict = dict;
    cell.buttonStr = _buttonStr;
    cell.block = ^{
        /**
         * 回购成功刷新界面
         */
        [self createDataArray:@"backCodeApi"];

    };
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
