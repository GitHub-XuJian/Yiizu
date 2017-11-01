//
//  HelpDetailsViewController.m
//  yizu
//
//  Created by 徐健 on 2017/10/28.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HelpDetailsViewController.h"

@interface HelpDetailsViewController ()

@end

@implementation HelpDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    [self createViewUI];
}
- (void)createViewUI
{
    /**
     * 带有行间距的高度
     */
    CGFloat label_H = [EncapsulationMethod getSpaceLabelHeight:self.detailsDict[@"description"] withFont:[UIFont systemFontOfSize:15] withWidth:kSCREEN_WIDTH-20 LineSpacing:10];

    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 74, kSCREEN_WIDTH-20, label_H);
    label.numberOfLines = 0;
    /**
     * 设置首行缩进和行间距
     */
    [EncapsulationMethod settingLabelTextAttributesWithLineSpacing:10 FirstLineHeadIndent:2 FontOfSize:15 TextColor:[UIColor blackColor] text:self.detailsDict[@"description"] AddLabel:label];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
