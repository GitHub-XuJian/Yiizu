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
#import "HomeDetailController.h"
#import "PopMenuView.h"

@interface HomeViewController ()<HomeCityBtnDelegate,PopmenuViewDelegate>
@property(nonatomic, strong)NSMutableArray* listArr;
//用于设置navbarbtn的标题
@property(nonatomic, strong)UIButton* navBtn;
//用于保存首页拼接城市id
@property(nonatomic, copy)NSString* homeListCityId;
//用于保存首页拼接区域id
@property(nonatomic, copy)NSString* homeListAreaId;

//首页接口页数
@property(nonatomic,assign)int currentPage;

//点击选择城市按钮请求城市全部商家接口
@property(nonatomic,copy)NSString* CityURLstr;
//点击区域列表内区域按钮请求区域内商家接口
@property(nonatomic,copy)NSString* homeUrlStr;




@end

@implementation HomeViewController

- (void)setHomeUrlStr:(NSString *)homeUrlStr
{
    _homeUrlStr=homeUrlStr;
    NSLog(@"点击区域按钮后区域商家接口:%@",homeUrlStr);
    //http://47.104.18.18/index.php/Mobile/Index/index_area/data/73/area/843/page/1/personid/3/sequence/
    [self requestData:homeUrlStr];
}
- (void)setCityURLstr:(NSString *)CityURLstr
{
    _CityURLstr=CityURLstr;
    NSLog(@"点击导航按钮:%@",CityURLstr);
    //点击导航按钮请求城市全部商家接口
    [self requestData:CityURLstr];
    
}
//- (NSMutableArray *)listArr
//{
//    if (_listArr==nil) {
//        _listArr=[[NSMutableArray alloc]init];
//    }
//    return _listArr;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    //self.automaticallyAdjustsScrollViewInsets = NO;
   
//    if (@available(iOS 10.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }
////////////////////////////////
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    self.navigationItem.title=@"依足";
    
    [self setNavBarBtn];
    
    //接受数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(massageCityId:) name:@"AreaId" object:nil];

    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saixuanId:) name:@"saixuan" object:nil];
    

    
    
    self.currentPage=1;
    self.homeListCityId=@"73";
    
    
    NSString*  newUrl=[NSString stringWithFormat:@"%@Mobile/Index/index_Chamber/data/73/page/%d",Main_Server,self.currentPage];
    [self requestData:newUrl];

    [self setupRefresh];
    
    
}
//【下拉刷新】【上拉加载】
-(void)setupRefresh{
    MJRefreshNormalHeader *header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
      //全城商户列表
      //http://47.104.18.18/index.php/Mobile/Index/index_Chamber/data/城/personid/3/sequence/（增加）默认是0 如果是1按照 点赞数排序/page/页数/
        NSString*  newUrl=[NSString stringWithFormat:@"%@Mobile/Index/index_Chamber/data/%@/personid/3/sequence/0/page/%d",Main_Server,self.homeListCityId,1];
        NSLog(@"下啦刷新回调:%@",newUrl);
        [self requestData:newUrl];
        //[self loadData];
       
    }];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer  =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        
        [self loadMore];
       // NSString* cid=[self.homeListCityId copy];
        //[self requestMoreData:cid];
        NSLog(@"上啦回调");
        
    }];
    self.tableView.mj_footer = footer;
    /////////////////////////////////
    self.tableView.mj_footer.automaticallyHidden=YES;
}

- (void)requestData:(NSString*)url
{
    _listArr=[[NSMutableArray alloc]init];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    [XAFNetWork GET:url params:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
       // NSLog(@"默认Data:%@",responseObject);
       
        
        //if ([responseObject[@"list"] isEqualToString:@"<null>"]) {
            
        
        //}else
        //{
            NSArray* arr=responseObject[@"list"];
            for (NSDictionary* dic in arr) {
                HomeListModel* model=[HomeListModel ModelWithDict:dic];
                
                [_listArr addObject:model];
                
            }
        //}

        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        [self endRefresh];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self endRefresh];
        [SVProgressHUD dismiss];
    }];
}
- (void)loadMore
{
    
    [SVProgressHUD showWithStatus:@"数据加载中..."];
     self.currentPage+=1;
    NSString*  newUrl=[NSString stringWithFormat:@"%@Mobile/Index/index_Chamber/data/73/page/%d",Main_Server,self.currentPage];
   
    [XAFNetWork GET:newUrl params:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {

        NSArray* arr=responseObject[@"list"];
        
        if (arr.count==0) {
            
            //[self.tableView.mj_footer endRefreshingWithNoMoreData];
            self.tableView.mj_footer.hidden=YES;
        }
        
        for (NSDictionary* dic in arr) {
            HomeListModel* model=[HomeListModel ModelWithDict:dic];
            /////////
            [_listArr addObject:model];
            
        }
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        [self endRefresh];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self endRefresh];
        [SVProgressHUD dismiss];
    }];
    
    
}
- (void)requestMoreData:(NSString*)cityId
{
//    [SVProgressHUD showWithStatus:@"数据加载中..."];
    self.currentPage+=1;
    NSString*  newUrl=[NSString stringWithFormat:@"%@Mobile/Index/index_Chamber/data/%@/page/%d",cityId,Main_Server,self.currentPage];
    
    [XAFNetWork GET:newUrl params:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        
        NSArray* arr=responseObject[@"list"];
        
        if (arr.count==0) {
            
            //[self.tableView.mj_footer endRefreshingWithNoMoreData];
            self.tableView.mj_footer.hidden=YES;
        }
        
        for (NSDictionary* dic in arr) {
            HomeListModel* model=[HomeListModel ModelWithDict:dic];
            /////////
            [_listArr addObject:model];
            
        }
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        [self endRefresh];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
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
#pragma mark-结束刷新方法
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark-通知回传
- (void)massageCityId:(NSNotification *)notification
{
    //NSLog(@"homelist接受到通知%@,%@",notification.userInfo[@"name"],notification.userInfo[@"areaId"]);
    //self.homeListAreaId=notification.userInfo[@"areaId"];
    self.homeUrlStr=notification.userInfo[@"areaUrl"];
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
- (void)HomeCityBtnTitle:(NSString *)title url:(NSString *)url cityId:(NSString *)cid
{
    NSLog(@"首页返回的url：%@",url);
    [self.navBtn setTitle:title forState:UIControlStateNormal];
    self.homeListCityId=cid;
    self.CityURLstr=url;
        NSDictionary *dict = @{@"name":title, @"cityId":cid};
    
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
    //HomeListModel* model
    cell.model=self.listArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetailController* dVC=[[HomeDetailController alloc]init];
    
    HomeListModel* model=self.listArr[indexPath.row];
    
    dVC.model=model;
    
    [self.navigationController pushViewController:dVC animated:YES];
    
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"123123");
}


- (void)saixuanId:(NSNotification *)notification
{
    NSString* newStr=notification.userInfo[@"areaUrl"];
    
    NSLog(@"homeNewStr===%@",newStr);
    [self requestData:newStr];
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
