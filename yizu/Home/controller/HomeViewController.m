//
//  HomeViewController.m
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeViewController.h"
#import "YTBarButtonItemSelecteView.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *item = nil;
    item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                         target:self
                                                         action:@selector(leftItemAction:)];
    self.navigationItem.leftBarButtonItem = item;
    
    
    [XAFNetWork GET:@"http://123.207.158.228/yizu/index.php/Mobile/Index/index_Chamber/data/73" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)leftItemAction:(UIBarButtonItem *)sender {
    YTBarButtonItemSelecteView *selecteView = [[YTBarButtonItemSelecteView alloc] initWithView:self.navigationController.view];
    [selecteView addActionWithTitle:@"Logs"
                              image:[UIImage imageNamed:@"history"]
                            handler:^(UIButton *action) {
                                self.navigationItem.title = @"left logs";
                            }];
    
    [selecteView addActionWithTitle:@"Edite"
                              image:[UIImage imageNamed:@"edit"]
                            handler:^(UIButton *action) {
                                self.navigationItem.title = @"left edite";
                                
                            }];
    
    [selecteView addActionWithTitle:@"more"
                              image:[UIImage imageNamed:@"more"]
                            handler:^(UIButton *action) {
                                self.navigationItem.title = @"left more";
                            }];
    
    [selecteView showBelowBarButtonItem:sender];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
