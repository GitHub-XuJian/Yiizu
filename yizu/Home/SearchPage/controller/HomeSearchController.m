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

#import "HomeCateDetailCell.h"
#import "HomeDetailController.h"

@interface HomeSearchController ()<UITableViewDelegate,UITableViewDataSource,CustomSearchBarDelegate>

@property (nonatomic,strong) CustomSearchBar *searchBar;
@property (nonatomic,strong) NoResultView* noResultView;
@property (nonatomic,copy) NSString *currentSeachText;
@property (nonatomic,strong) NSMutableArray* seachArr;
@property (nonatomic,strong) UITableView* tableView;

@property (nonatomic,assign) BOOL showHistory;

@end

@implementation HomeSearchController

- (NSMutableArray *)seachArr
{
    if (_seachArr == nil) {
        _seachArr =[[NSMutableArray alloc]init];
    }
    return _seachArr;
    
}

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
     NSLog(@"44444444444444");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
      [self.navigationController setNavigationBarHidden:NO];
     NSLog(@"3333333333333");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
     NSLog(@"2222222222222");
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
    NSLog(@"111111111111111");
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
    //拖动tableView隐藏键盘
    //tab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tab.separatorStyle = NO;
    tab.delegate=self;
    tab.dataSource=self;
    UINib* nib=[UINib nibWithNibName:@"HomeCateDetailCell" bundle:nil];
    [tab registerNib:nib forCellReuseIdentifier:@"catecell"];
    [self.view addSubview:tab];
    self.tableView=tab;
    
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
    return self.seachArr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeCateDetailCell* cell=[tableView dequeueReusableCellWithIdentifier:@"catecell"];
    
    
    HomeListModel* model=self.seachArr[indexPath.row];
    cell.model=model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
#pragma mark-UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetailController* hdc=[[HomeDetailController alloc]init];
    
    hdc.model=self.seachArr[indexPath.row];
    
    
    [self.navigationController pushViewController:hdc animated:YES];
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setShowHistory:(BOOL)showHistory {
    _showHistory = showHistory;
    //self.historyView.hidden = !showHistory;
}
- (void)searchText:(NSString *)text
{
    
//    self.showHistory = text.length < 1;
//
//    if (self.showHistory || text.length > 12) return;
//
//    //清空格
//    self.currentSeachText = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"清空格后:%@",self.currentSeachText);
//    //转UTF-8
//    NSString *keyword   = [self.currentSeachText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString* str=[NSString stringWithFormat:@"%@/Mobile/Index/index_name/name/%@/page/1",Main_Server,keyword];
//
//    [XAFNetWork GET:str params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"搜索数据=%@",responseObject);
//        NSArray* arr=responseObject[@"list"];
//        for (NSDictionary* dic in arr) {
//            HomeListModel* model=[HomeListModel ModelWithDict:dic];
//            [_seachArr addObject:model];
//        }
//        BOOL hasResult = _seachArr.count > 0;
//         NSLog(@"是否隐藏:%d",hasResult);
//        self.noResultView.hidden = hasResult;
//        if (hasResult) {
//            [self.tableView reloadData];
//        }
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//
//    }];
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


- (void)customaSearchClikeReturn:(UITextField *)textfield textDid:(NSString *)text
{
    [textfield resignFirstResponder];//主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    
  
    
    //    //清空格
        self.currentSeachText = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        //转UTF-8
        NSString *keyword  = [self.currentSeachText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString* str=[NSString stringWithFormat:@"%@/Mobile/Index/index_name/name/%@/page/1",Main_Server,keyword];
    
   
    //
    [SVProgressHUD show];
        [XAFNetWork GET:str params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"搜索数据=%@",responseObject);
            NSArray* arr=responseObject[@"list"];
            for (NSDictionary* dic in arr) {
                HomeListModel* model=[HomeListModel ModelWithDict:dic];
                [_seachArr addObject:model];
            }
            BOOL hasResult = _seachArr.count > 0;
             NSLog(@"是否隐藏:%d",hasResult);
            self.noResultView.hidden = hasResult;
            if (hasResult) {
                [self.tableView reloadData];
                [SVProgressHUD dismiss];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
    
            [SVProgressHUD dismiss];
        }];
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
