//
//  CSdetailsViewController.m
//  yizu
//
//  Created by 徐健 on 2017/10/28.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#define Label_H 50

#import "CSdetailsViewController.h"

@interface CSdetailsViewController ()

@end

@implementation CSdetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    self.title = self.dataDict[@"servename"];
    [self createUiView];
}
- (void)createUiView
{
    NSArray *array = @[@"servename",@"mobile",@"emali",@"weixi",@"qqnum",@"charge"];
    NSArray *array1 = @[@"姓名:",@"电话:",@"邮箱:",@"微信:",@"QQ:",@"负责内容:"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, array1.count*Label_H)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    for (int i = 0; i < array1.count; i++) {
        UILabel *label  = [[UILabel alloc] init];
        label.frame = CGRectMake(10, i*Label_H, 80, Label_H);
        label.text = array1[i];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        [view addSubview:label];
        
        UILabel *label2  = [[UILabel alloc] init];
        label2.frame = CGRectMake(label.x+label.width+5, label.y, kSCREEN_WIDTH-label.x-label.width, Label_H);
        label2.text = self.dataDict[array[i]];
        label2.backgroundColor = [UIColor clearColor];
        [view addSubview:label2];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame= CGRectMake(0, label.y+label.height, kSCREEN_WIDTH, 0.5);
        lineView.backgroundColor = kColorLine;
        [view addSubview:lineView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
