//
//  HomeSearchController.m
//  yizu
//
//  Created by myMac on 2017/10/30.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeSearchController.h"
#import "CustomSearchBar.h"
@interface HomeSearchController ()
@property (nonatomic,weak) CustomSearchBar *searchBar;
@end

@implementation HomeSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupSeachBar];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 设置子视图

- (void)setupSeachBar {
    
    CustomSearchBar *searchBar = [CustomSearchBar makeCustomSearchBar];
    
    searchBar.frame=CGRectMake(0, 0, self.view.frame.size.width, 64);
    [self.view addSubview:searchBar];
    
    //searchBar.delegate = self;
    
    //    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.left.right.equalTo(self.view);
    //        make.height.equalTo(@(navHeight));
    //    }];
    
    self.searchBar = searchBar;
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
