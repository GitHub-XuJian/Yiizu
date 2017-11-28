//
//  registerViewController.m
//  registrationDebarkation
//
//  Created by 邵峰 on 2017/4/7.
//  Copyright © 2017年 邵峰. All rights reserved.
//

#import "registerViewController.h"
#import "registeredView.h"
#import "IQKeyboardManager.h"
//#import "SFNetWorkManager.h"
//#import "SFProgressHUD.h"

@interface registerViewController ()<UITextFieldDelegate>

@property(nonatomic, strong) registeredView *registerView;
@end

@implementation registerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}



- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRegisterInterface];
}

- (void)loadRegisterInterface
{
    _registerView = [[registeredView alloc] init];;
    _registerView.frame = self.view.frame;
    [self.view addSubview:_registerView];
}

-(void)dealloc{

}

@end
