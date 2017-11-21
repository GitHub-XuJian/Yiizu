//
//  PersonalInformationViewController.m
//  yizu
//
//  Created by 徐健 on 2017/11/7.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "PersonalInformationTableViewCell.h"
#import "ZZYPhotoHelper.h"

@interface PersonalInformationViewController ()<UITableViewDelegate,UITableViewDataSource,PWCustomSheetDelegate>
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    [self createDataArray];
    [self createTableView];
}
- (void)createDataArray
{
    self.dataArray = [NSMutableArray arrayWithObjects:@"头像",@"昵称",@"性别",@"个性签名", nil];
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
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80;
    }
    return 60 ;
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
    PersonalInformationTableViewCell  *cell  = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[PersonalInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier andIndexPath:indexPath];
    }
    cell.leftNameStr = self.dataArray[indexPath.row];
    return cell;
}


//响应点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"响应单击事件");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            NSLog(@"更改头像");
            [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
                UIImage *image = (UIImage *)data;
                NSLog(@"%@",image);
                
                NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Headpic/headpicApi",Main_Server];
                NSMutableArray *imageDataArray = [[NSMutableArray alloc] init];
                [imageDataArray addObject:image];
                
                NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey]};
                
                [XAFNetWork uploadImageWithOperations:dict withImageArray:imageDataArray withtargetWidth:image.size.width withUrlString:urlStr withImageName:@"headpic" withSuccessBlock:^(NSURLSessionDataTask *task, id responseObject) {
                    NSLog(@"%@",responseObject);
                    jxt_showAlertTitle(responseObject[@"message"]);
                    if ([responseObject[@"result"] integerValue]) {
                        [XSaverTool setObject:responseObject[@"url"] forKey:UserIconImage];
                    }
                } withFailurBlock:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"%@",error);
                } withUpLoadProgress:^(NSProgress *progress) {
                    
                }];
            }];
            break;
        }
        case 2:{
            NSLog(@"更改性别");
            NSArray * ar = @[@"男",@"女"];
            PWCustomSheet * sheet = [[PWCustomSheet alloc]initWithButtons:ar];
            sheet.delegate =self;
            [self.view addSubview:sheet];
            break;
        }
        case 3:{
            NSLog(@"实名认证");
            break;
        }
        default:
            break;
    }
}
-(void)clickButton:(UIButton *)button
{
    NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey],@"sex":[NSString stringWithFormat:@"%ld",button.tag+1]};
    NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Mine/modifydata",Main_Server];
    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue]) {
            [XSaverTool setObject:[NSString stringWithFormat:@"%ld",button.tag+1] forKey:Sex];
            [self.tableView reloadData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
