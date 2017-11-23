//
//  DisplayCardViewController.m
//  yizu
//
//  Created by 徐健 on 2017/11/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "DisplayCardViewController.h"

@interface DisplayCardViewController ()

@end

@implementation DisplayCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    [self createView];
}
- (void)createView
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+10, kSCREEN_WIDTH, 60)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BankCard"]];
    imageView.frame = CGRectMake(10, 5, 50, 50);
    [backView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(imageView.x+imageView.width+10, 0, kSCREEN_WIDTH-(imageView.x+imageView.width+10), 60);
    label.text = [NSString stringWithFormat:@"%@(%@)",_cardDict[@"bancarname"],_cardDict[@"bankcard"]];
    [backView addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
