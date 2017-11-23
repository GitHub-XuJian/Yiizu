//
//  WebViewController.m
//  yizu
//
//  Created by 徐健 on 2017/11/7.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation WebViewController
- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        [self.view addSubview:_webView];
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loadFile];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (!self.navigationController) {
        [self createBackBtn];
    }
    [self loadString:self.urlStr];

}
- (void)createBackBtn
{
    SFNavView *navView = [[SFNavView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 64) andTitle:@"用户使用协议" andLeftBtnTitle:@"返回" andRightBtnTitle:nil andLeftBtnBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    } andRightBtnBlock:^{
        
    }];
    [self.view addSubview:navView];
}
#pragma mark - 加载本地文件
- (void)loadFile
{
    // 应用场景:加载从服务器上下载的文件,例如pdf,或者word,图片等等文件
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"bang.html" withExtension:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    
    [self.webView loadRequest:request];
}
#pragma mark - 加载URL
- (void)loadString:(NSString *)str
{
    NSURL *url = [NSURL URLWithString:str];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
