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
    //拖动tableView隐藏键盘
    //tab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tab.delegate=self;
    tab.dataSource=self;
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
    static NSString* identifier=@"cell";
    UITableViewCell*  cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    HomeListModel* model=self.seachArr[indexPath.row];
    cell.textLabel.text=model.chambername;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/img/img/%@",Main_ServerImage,model.image1]]];
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

- (void)setShowHistory:(BOOL)showHistory {
    _showHistory = showHistory;
    //self.historyView.hidden = !showHistory;
}
- (void)searchText:(NSString *)text
{
    
    self.showHistory = text.length < 1;
    
    if (self.showHistory || text.length > 12) return;
    
    //清空格
    self.currentSeachText = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"清空格后:%@",self.currentSeachText);
    //转UTF-8
    NSString *keyword   = [self.currentSeachText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* str=[NSString stringWithFormat:@"%@/Mobile/Index/index_name/name/%@/page/1",Main_Server,keyword];
    
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
        }
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
