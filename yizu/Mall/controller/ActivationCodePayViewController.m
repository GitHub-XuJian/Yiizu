//
//  ActivationCodePayViewController.m
//  yizu
//
//  Created by 徐健 on 2017/11/14.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ActivationCodePayViewController.h"
#import "ActivationCodePayTableViewCell.h"

@interface ActivationCodePayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray *selectorPatnArray;
@end

@implementation ActivationCodePayViewController
- (NSMutableArray *)selectorPatnArray
{
    if(!_selectorPatnArray){
        _selectorPatnArray = [NSMutableArray array];
    }
    return _selectorPatnArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createRightBtn];
    [self createData];
    [self createUIView];
}
-(void)createRightBtn
{
    UIButton *releaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    releaseButton.frame = CGRectMake(0, 0, 44, 44);
    [releaseButton setTitle:@"支付" forState:normal];
    [releaseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [releaseButton addTarget:self action:@selector(payClickedOKbtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releaseButton];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;
}
- (void)payClickedOKbtn {
    NSLog(@"payClickedOKbtn");
    if (_selectorPatnArray.count) {
        /**
         * 总钱数
         */
        NSInteger allMoney = 0;
        NSMutableArray *allcodeIdarray = [NSMutableArray array];
        for (int i = 0; i < _selectorPatnArray.count; i++) {
            NSDictionary *dict = _selectorPatnArray[i];
            [allcodeIdarray addObject:@{@"codeid":dict[@"codeid"]}];
            NSInteger money = [dict[@"paymoney"] integerValue];
            allMoney += money;
        }
        NSLog(@"%ld",allMoney);
        NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey],@"codePrice":[NSString stringWithFormat:@"%ld",allMoney],@"memberPrice":[_moneyDict objectForKey:@"money"],@"tian":[_moneyDict objectForKey:@"tian"],@"code":allcodeIdarray};
        NSString *jsonStr = [EncapsulationMethod dictToJsonData:dict];
        NSString *urlStr = [[NSString stringWithFormat:@"%@Mobile/Member/memberCodeSSPP/data/%@",Main_Server,jsonStr] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [XAFNetWork GET:urlStr params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            jxt_showAlertTitle(responseObject[@"message"]);
            if ([responseObject[@"result"] integerValue] == 1) {
                NSDictionary *dictData = responseObject[@"data"];
                [XSaverTool setObject:dictData[@"vipbegintime"] forKey:VipBegintime];
                [XSaverTool setObject:dictData[@"vipendtime"] forKey:VipEndtime];
                [XSaverTool setObject:dictData[@"pername"] forKey:Pername];
                [XSaverTool setObject:dictData[@"statevip"] forKey:Statevip];
            
                [self.navigationController popViewControllerAnimated:YES];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }else{
        jxt_showAlertTitle(@"请选择激活码");
    }
    
}
-(void)createData
{
    NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey]};
    NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Member/codeApi",Main_Server];
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        self.dataArray = responseObject;
        [self.tableView reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)createUIView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,kSCREEN_WIDTH,kSCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = kClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setEditing:YES animated:YES];
    [self.view addSubview:self.tableView];
   
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
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

// 构建tableView的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //必须用一个静态字符串
    static NSString *cellIdentifier = @"cell";
    
    // 判断是有空闲的cell,有进行重用，没有就创建一个
    ActivationCodePayTableViewCell  *cell  = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[ActivationCodePayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.dictCell = self.dataArray[indexPath.row];
    return cell;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return  UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中数据
    [self.selectorPatnArray addObject:self.dataArray[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //从选中中取消
    if (self.selectorPatnArray.count > 0) {
        [self.selectorPatnArray removeObject:self.dataArray[indexPath.row]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
