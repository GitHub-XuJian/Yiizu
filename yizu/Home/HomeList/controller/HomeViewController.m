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
@property(nonatomic, strong)NSMutableArray* listArr;

@property(nonatomic, strong)UIButton* navBtn;
//用于保存首页拼接城市接口
@property(nonatomic, copy)NSString* homeListCityId;
//用于保存首页拼接区域接口
@property(nonatomic, copy)NSString* homeListAreaId;
//
@property(nonatomic, copy)NSString* homeURL;






@end

@implementation HomeViewController

- (void)setListArr:(NSMutableArray *)listArr
{
    _listArr=listArr;
    [self.tableView reloadData];
    [SVProgressHUD dismiss];
    [self endRefresh];
}

- (void)setHomeListCityId:(NSString *)homeListCityId
{
    _homeListAreaId=homeListCityId;
    self.homeURL=[NSString stringWithFormat:@"http://123.207.158.228/yizu/index.php/Mobile/Index/index_area/data/%@",homeListCityId];
#define HOMENAVBTNURL @"http://123.207.158.228/yizu/index.php/Mobile/Index/index_Chamber/data/%@/page/1"
    NSString* cityURL=[NSString stringWithFormat:HOMENAVBTNURL,homeListCityId];
    [self loadData:cityURL];
    NSLog(@"全部商城接口 %@",cityURL);
}

-(void)setHomeListAreaId:(NSString *)homeListAreaId
{
    _homeListAreaId=homeListAreaId;
    NSString* areaUrl=[NSString stringWithFormat:@"/area/%@/page/1",homeListAreaId];
    NSString* url=[self.homeURL stringByAppendingString:areaUrl];
    
    NSLog(@"点击城市和区域Url=%@",url);

    [HomeListModel HomeListWithUrl:url success:^(NSMutableArray *array) {
        self.listArr=array;
        NSLog(@"再次请求");
    } error:^{
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title=@"依足";
    [self setNavBarBtn];
    
    //接受数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(massageCityId:) name:@"AreaId" object:nil];

    NSString* urlStr=@"http://123.207.158.228/yizu/index.php/Mobile/Index/index_Chamber/data/73/page/1";
    [self loadData:urlStr];
    

    //【下拉刷新】【上拉加载】
    [self setupRefresh];

    
    
    
}
-(void)setupRefresh{
    MJRefreshNormalHeader *header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSString* urlStr=@"http://123.207.158.228/yizu/index.php/Mobile/Index/index_Chamber/data/73/page/1";
        [self loadData:urlStr];
    }];
    
    self.tableView.mj_header = header;
    
//    MJRefreshAutoNormalFooter *footer  =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//
//        [self loadMore];
//    }];
//
//    self.tableView.mj_footer = footer;
}
#pragma mark-结束刷新方法
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)loadMore
{
    [SVProgressHUD showWithStatus:@"数据加载中..."];
#define MoreHomeList @"http://123.207.158.228/yizu/index.php/Mobile/Index/index_area/data/73/area/843/page/%d"
    NSString* strUrl=[NSString stringWithFormat:MoreHomeList,2];

    [self endRefresh];
    [SVProgressHUD dismiss];

}
- (void)loadData:(NSString*)strURL
{
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    //http://123.207.158.228//yizu/index.php/Mobile/Index/index_Chamber/data/城市id
    //http://123.207.158.228/yizu/index.php/Mobile/Index/index_Chamber/data/73/page/1

    [HomeListModel HomeListWithUrl:strURL success:^(NSMutableArray *array) {
        self.listArr=array;

    } error:^{
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
          [self endRefresh];
        [SVProgressHUD dismiss];

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
