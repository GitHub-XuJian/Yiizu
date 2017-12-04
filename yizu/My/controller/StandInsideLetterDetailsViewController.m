//
//  StandInsideLetterDetailsViewController.m
//  yizu
//
//  Created by 徐健 on 2017/12/4.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "StandInsideLetterDetailsViewController.h"

@interface StandInsideLetterDetailsViewController ()

@end

@implementation StandInsideLetterDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =kMAIN_BACKGROUND_COLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUIView];
    NSLog(@"%@",self.detailsDict);
}
- (void)createUIView
{
    /**
     * 带有行间距的高度
     */
   NSString * msg = [NSString stringWithFormat:@"%@",[self.detailsDict[@"message"] stringByReplacingOccurrencesOfString:@"\\n" withString:@" \r\n" ]];
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(10, 64, kSCREEN_WIDTH-20, kSCREEN_HEIGHT-64);
    textView.backgroundColor = [UIColor clearColor];
    textView.editable = NO;
    /**
     * 设置首行缩进和行间距
     */
    [EncapsulationMethod settingLabelTextAttributesWithLineSpacing:10 FirstLineHeadIndent:2 FontOfSize:15 TextColor:[UIColor blackColor] text:msg AddLabel:textView];
    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
