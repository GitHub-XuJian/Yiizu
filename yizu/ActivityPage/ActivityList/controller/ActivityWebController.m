//
//  ActivityWebController.m
//  yizu
//
//  Created by myMac on 2017/11/24.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ActivityWebController.h"

@interface ActivityWebController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView* webView;

@end

@implementation ActivityWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
    
    NSString* webUrl=[NSString stringWithFormat:@"%@Mobile/Bridge/Bridgeitem/activityid/%@/",Main_Server,self.activiId];
    
    self.webView.delegate=self;
    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]];
    
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
    
    
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
