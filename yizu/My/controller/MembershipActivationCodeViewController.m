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
#import <UShareUI/UShareUI.h>
#import "SlotMachines.h"

@interface MembershipActivationCodeViewController ()<UITableViewDelegate,UITableViewDataSource,SlotMachinesDelegate>
{
    NSString *_buttonStr;
    NSDictionary *_shareDict;
}
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) MembershipActivationCodeView *macView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SlotMachines *slotMachinesView;
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
    
}
- (void)createDataArray:(NSString *)str
{
    [SVProgressHUD showWithStatus:@"正在加载..."];

    NSString *urlStr =[NSString stringWithFormat:@"%@Mobile/Code/%@",Main_Server,str];
    NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey]};
    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        [SVProgressHUD dismiss];
        self.dataArray = responseObject;
        if ([responseObject count] == 0) {
//            jxt_showToastTitle(@"暂无数据", 1);
        }
        [self.tableView reloadData];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)createViewUI
{
    _buttonStr = @"分享";
    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:@"未分享",@"已分享",@"可回购",@"已回购", nil];
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
                [self createDataArray:@"activate"];
                
                break;
            }
            case 2:{
                _buttonStr = @"回购";
                [self createDataArray:@"backCodeApi"];
                
                break;
            }
            case 3:{
                _buttonStr = @"已回购";
                [self createDataArray:@"Share"];
                
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
    __block NSDictionary *cellDict = self.dataArray[indexPath.row];
    cell.dict = cellDict;
    cell.buttonStr = _buttonStr;
    cell.block = ^(UIButton *btn) {
        if ([btn.titleLabel.text isEqualToString:@"回购"]) {
            jxt_showAlertTwoButton(@"提示", @"是否回购", @"确定", ^(NSInteger buttonIndex) {
                NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey],@"codeid":cellDict[@"codeid"]};
                NSString *urlStr = [[NSString stringWithFormat:@"%@Mobile/Code/backApi/data/%@",Main_Server,[EncapsulationMethod dictToJsonData:dict]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                [XAFNetWork GET:urlStr params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                    jxt_showAlertTitle(responseObject[@"message"]);
                    if ([responseObject[@"result"] integerValue]) {
                        /**
                         * 回购成功刷新界面
                         */
                        [self createDataArray:@"backCodeApi"];
                        
                    }
                } fail:^(NSURLSessionDataTask *task, NSError *error) {
                    jxt_showAlertTitle(@"请求失败");
                }];
            }, @"取消", ^(NSInteger buttonIndex) {
                
            });
        }else if ([btn.titleLabel.text isEqualToString:@"分享"]){
            NSLog(@"分享");
            _shareDict = cellDict;
            [self shareClick];
        }else if ([btn.titleLabel.text isEqualToString:@"提现"]){
            NSLog(@"提现");
            jxt_showAlertTwoButton(@"提示", @"是否提现", @"确定", ^(NSInteger buttonIndex) {
                NSDictionary *dict = @{@"codeid":cellDict[@"codeid"]};
                NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Code/exchange",Main_Server];
                [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                    jxt_showAlertTitle(responseObject[@"message"]);
                    if ([responseObject[@"result"] integerValue]) {
                        /**
                         * 提现成功刷新界面
                         */
                        [self createDataArray:@"activate"];
                    }
                } fail:^(NSURLSessionDataTask *task, NSError *error) {
                    jxt_showAlertTitle(@"请求失败");
                }];
            }, @"取消", ^(NSInteger buttonIndex) {
                
            });
        }
    };
    return cell;
}
/**
 * 分享
 */
- (void)shareClick {
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareImageAndTextToPlatformType:platformType];
    }];
}
//分享网址
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
{
    WEAKSELF;

    NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Code/shareMoney",Main_Server];
    NSDictionary *dict = @{@"codeid":_shareDict[@"codeid"]};
    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建网页内容对象
        NSString* thumbURL = [NSString stringWithFormat:@"%@%@",Main_ServerImage,responseObject[@"pic"]];
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"我又在依足领到现金补贴啦！" descr:[NSString stringWithFormat:@"我在%@，领到了依足%.2f元现金补贴",responseObject[@"chambername"],[responseObject[@"nextmoney"] floatValue]+[responseObject[@"paymoney"] floatValue]] thumImage:thumbURL];
        //设置网页地址
        shareObject.webpageUrl = [NSString stringWithFormat:@"%@%@/codeid/%@",Main_ServerImage,responseObject[@"url"],_shareDict[@"codeid"]];
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************分享失败与错误 %@*********",error);
                jxt_showAlertTitle(@"分享失败");
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                    NSString *urlStr =[NSString stringWithFormat:@"%@Mobile/Code/shareApi",Main_Server];
                    NSDictionary *dict = @{@"codeid":_shareDict[@"codeid"]};
                    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                        NSLog(@"%@",responseObject);
                        jxt_showAlertOneButton(@"提示", responseObject[@"message"], @"确定", ^(NSInteger buttonIndex) {
                            if ([responseObject[@"result"] integerValue]) {
                                
                                SlotMachines *slotMachinesView = [[SlotMachines alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
                                slotMachinesView.delegate = weakSelf;
                                slotMachinesView.dict = responseObject;
                                slotMachinesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
                                [self.view.window addSubview:slotMachinesView];
                                self.slotMachinesView = slotMachinesView;
                            }
                        });
                        
                    } fail:^(NSURLSessionDataTask *task, NSError *error) {
                        
                    }];
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
//            [self alertWithError:error];
        }];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)determineBtnClick
{
    [self.slotMachinesView removeFromSuperview];
    /**
     * 分享成功刷新界面
     */
    [self createDataArray:@"notShareApi"];
    
}

- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"分享失败,错误代码: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"分享失败"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
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
