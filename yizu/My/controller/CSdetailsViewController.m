//
//  CSdetailsViewController.m
//  yizu
//
//  Created by 徐健 on 2017/10/28.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "CSdetailsViewController.h"

@interface CSdetailsViewController ()

@end

@implementation CSdetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.dataDict[@"servename"];
    [self createUiView];
}
- (void)createUiView
{
    NSArray *array = @[@"servename",@"mobile",@"emali",@"weixi",@"qqnum",@"charge"];
    NSArray *array1 = @[@"姓名:",@"电话:",@"邮箱:",@"微信:",@"QQ:",@"负责内容:"];
    
    for (int i = 0; i < array1.count; i++) {
        UILabel *label  = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 64+i*50, 80, 40);
        label.text = array1[i];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:label];
        
        UILabel *label2  = [[UILabel alloc] init];
        label2.frame = CGRectMake(label.x+label.width+5, label.y, kSCREEN_WIDTH-label.x-label.width, 40);
        label2.text = self.dataDict[array[i]];
        label2.backgroundColor = [UIColor clearColor];
        [self.view addSubview:label2];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame= CGRectMake(0, label.y+label.height, kSCREEN_WIDTH, 0.5);
        lineView.backgroundColor = kColorLine;
        [self.view addSubview:lineView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
