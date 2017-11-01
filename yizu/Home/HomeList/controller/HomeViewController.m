//
//  HomeViewController.m
//  yizu
//
//  Created by myMac on 2017/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeListCell.h"
#import "HomeCityBtnController.h"
#import "HomeListModel.h"
#import "LoopImageViewController.h"
#import "HomeSearchController.h"

@interface HomeViewController ()<HomeCityBtnDelegate>
@property(nonatomic, strong)NSArray* listArr;
@property(nonatomic, strong)UIButton* navBtn;
//用于保存首页拼接城市接口
@property(nonatomic, copy)NSString* homeListCityId;
//用于保存首页拼接区域接口
@property(nonatomic, copy)NSString* homeListAreaId;





@end

@implementation HomeViewController

- (void)setListArr:(NSArray *)listArr
{
    _listArr=listArr;
    [self.tableView reloadData];
}

//- (void)setHomeListCityId:(NSString *)homeListCityId
//{
//    _homeListAreaId=homeListCityId;
//}

-(void)setHomeListAreaId:(NSString *)homeListAreaId
{
    _homeListAreaId=homeListAreaId;
    NSString* url=[NSString stringWithFormat:@"http://123.207.158.228/yizu/index.php/Mobile/Index/index_area/data/%@/area/%@/page/1",self.homeListCityId,self.homeListAreaId];
    NSLog(@"点击城市和区域Url=%@",url);
    [HomeListModel HomeListWithUrl:url success:^(NSArray *array) {
        
        self.listArr=array;
        NSLog(@"不是第一次");
    } error:^{
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"依足";
    [self setNavBarBtn];
    
    //接受数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(massageCityId:) name:@"AreaId" object:nil];

    [self loadData];
    
  
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadData];
        
        [self.tableView.mj_header endRefreshing];
        
    }];
    
    
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.tableView.mj_header beginRefreshing];
//}
- (void)loadData
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [HomeListModel HomeListWithUrl:@"http://123.207.158.228/yizu/index.php/Mobile/Index/index_area/data/73/area/843/page/1" success:^(NSArray *array) {
        self.listArr=array;
        
        [SVProgressHUD dismiss];
    } error:^{
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
    }];
}

- (void)setNavBarBtn
{
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"沈阳" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 70, 60)];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn addTarget:self action:@selector(navBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* btn2=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=btn2;
    self.navBtn=btn;
    
    UIImage *searchIcon = [[UIImage imageNamed:@"ic_searchbar_15x16_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithImage:searchIcon style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    
    self.navigationItem.rightBarButtonItem = search;
}
- (void)search
{
    HomeSearchController* sVC=[[HomeSearchController alloc]init];
    UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:sVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark-通知回传
- (void)massageCityId:(NSNotification *)notification
{
    //NSLog(@"homelist接受到通知%@,%@",notification.userInfo[@"name"],notification.userInfo[@"areaId"]);
    self.homeListAreaId=notification.userInfo[@"areaId"];
   
}
#pragma mark-首页导航条按钮
- (void)navBtnAction
{
    HomeCityBtnController* hVC=[[HomeCityBtnController alloc]init];
    hVC.delegate=self;
    UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:hVC];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}
#pragma mark- homeCityBtnDelegate
-(void)HomeCityBtnTitle:(NSString *)title url:(NSString *)url
{
    [self.navBtn setTitle:title forState:UIControlStateNormal];
    self.homeListCityId=url;
    NSDictionary *dict = @{@"name":title, @"cityId":url};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"nameId" object:nil userInfo:dict];
    
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeListCell* cell=[tableView dequeueReusableCellWithIdentifier:@"home"];
    cell.model=self.listArr[indexPath.row];
    

    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
