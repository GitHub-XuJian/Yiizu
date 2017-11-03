//
//  HomeSearchController.m
//  yizu
//
//  Created by myMac on 2017/10/30.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeSearchController.h"
#import "CustomSearchBar.h"
#import "XAFNetWork.h"
#import "HomeListModel.h"
#import "NoResultView.h"

@interface HomeSearchController ()<UITableViewDelegate,UITableViewDataSource,CustomSearchBarDelegate>

@property (nonatomic,strong) CustomSearchBar *searchBar;
@property (nonatomic,strong) NoResultView* noResultView;
@property (nonatomic,copy) NSString *currentSeachText;
@property (nonatomic,strong) NSMutableArray* seachArr;

@end

@implementation HomeSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createSeachBar];
    [self createUITableView];
    [self createNoResult];
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

#pragma mark 设置子视图
- (void)createSeachBar {
    
    CustomSearchBar *searchBar = [CustomSearchBar makeCustomSearchBar];
    
    searchBar.frame=CGRectMake(0, 0, self.view.frame.size.width, 64);
    [self.view addSubview:searchBar];
    
    searchBar.delegate = self;
    
    self.searchBar = searchBar;
}
- (void)createUITableView
{
    UITableView* tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    tab.delegate=self;
    tab.dataSource=self;
    [self.view addSubview:tab];
    
}
- (void)createNoResult
{
    NoResultView* nView=[NoResultView new];
    nView.hidden=YES;
    [self.view addSubview:nView];
    self.noResultView=nView;
}
#pragma mark-UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier=@"cell";
    UITableViewCell*  cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
#pragma mark-UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)searchText:(NSString *)text
{
  
    //清空格
    self.currentSeachText = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
#define SEACHURL @"http://123.207.158.228/yizu/index.php/Mobile/Index/index_name/name/%@/page/1"
    NSString* str=[NSString stringWithFormat:SEACHURL,text];
    //转UTF-8
    NSString *keyword   = [self.currentSeachText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"搜索框输入:%@=%@",keyword,str);
    //static NSString * const searchBaseUrl = @"http://search";
    NSString *urlString = [NSString stringWithFormat:@"%@?key1=%@&key2=%d&key3=%d",SEACHURL,keyword,20,0];
    //http://123.207.158.228/yizu/index.php/Mobile/Index/index_name/name/%@/page/1?key1=a&key2=20&key3=0
    NSLog(@"pinjiekou%@",urlString);
    [XAFNetWork GET:str params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"2221v111222=%@",responseObject);
          BOOL hasResult = self.seachArr.count > 0;
          self.noResultView.hidden = hasResult;
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark SearchBarDelegate
- (void)customSearchBarDidBeginEditing:(CustomSearchBar *)searchBar {
    
}

- (void)customSearchBar:(CustomSearchBar *)searchBar textDidChange:(NSString *)text {
    [self searchText:text];
}

- (void)customSearchBarNeedDisMiss:(CustomSearchBar *)searchBar {
    [self dismissViewControllerAnimated:NO completion:nil];
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
