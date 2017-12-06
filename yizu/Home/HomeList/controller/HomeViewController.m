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
#import "CustomNavigationController.h"
#import "CellBtn.h"
#import  <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>




@interface HomeViewController ()<HomeCityBtnDelegate,LikeBtnViewDelegate,CLLocationManagerDelegate>
{
    CGFloat _offset;
}
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


@property (nonatomic, assign) BOOL isLikeStart;

@property(nonatomic, strong) CLLocationManager *locationManager;

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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.clipsToBounds = 0.0;
   
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
////////////////////////////////
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    //self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
  
    
    [self setNavBarBtn];
    
    //接受数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(massageCityId:) name:@"AreaId" object:nil];

    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saixuanId:) name:@"saixuan" object:nil];
    

    
    
    self.currentPage=1;
    self.homeListCityId=@"73";
    
      NSString* newUrl=@"";
      if (!IsLoginState)
      {
          //http:// 47.104.18.18/index.php/Mobile/Index/index_Chamber/data/城市id
          //personid/3/sequence/0/page/页数/
         newUrl= [NSString stringWithFormat:@"%@Mobile/Index/index_Chamber/data/%@/personid/0/sequence/0/page/%d",Main_Server,self.homeListCityId,self.currentPage];

      }else
      {
          newUrl= [NSString stringWithFormat:@"%@Mobile/Index/index_Chamber/data/%@/personid/%@/sequence/0/page/%d",Main_Server,self.homeListCityId,[XSaverTool objectForKey:UserIDKey],self.currentPage];

      }
     //newUrl= [NSString stringWithFormat:@"%@Mobile/Index/index_Chamber/data/%@/personid/%@/sequence/0/page/%d",Main_Server,self.homeListCityId,[XSaverTool objectForKey:UserIDKey],self.currentPage];
    NSLog(@"第一次请求=%@",newUrl);
    
    [self requestData:newUrl];

    [self setupRefresh];
   
    NSLog(@"%@",NSStringFromCGRect(self.tableView.tableHeaderView.frame));
}
//【下拉刷新】【上拉加载】
-(void)setupRefresh{
    MJRefreshNormalHeader *header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_listArr removeAllObjects];
      //全城商户列表
    
        NSString* newUrl=@"";
        if (!IsLoginState)
        {

            newUrl= [NSString stringWithFormat:@"%@Mobile/Index/index_Chamber/data/%@/personid/0/sequence/0/page/%d",Main_Server,self.homeListCityId,1];
        }else
        {
            newUrl= [NSString stringWithFormat:@"%@Mobile/Index/index_Chamber/data/%@/personid/%@/sequence/0/page/%d",Main_Server,self.homeListCityId,[XSaverTool objectForKey:UserIDKey],1];
        }
    
      
        NSLog(@"下啦刷新回调:%@",newUrl);
        [self requestData:newUrl];
        //[self loadData];
       
    }];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer  =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
          self.currentPage+=1;
        NSString* newUrl=@"";
        if (!IsLoginState)
        {
            
            newUrl= [NSString stringWithFormat:@"%@Mobile/Index/index_Chamber/data/%@/personid/0/sequence/0/page/%d",Main_Server,self.homeListCityId,self.currentPage];
        }else
        {
            newUrl= [NSString stringWithFormat:@"%@Mobile/Index/index_Chamber/data/%@/personid/%@/sequence/0/page/%d",Main_Server,self.homeListCityId,[XSaverTool objectForKey:UserIDKey],self.currentPage];
        }
       
        [self requestMoreData:newUrl];
        NSLog(@"上啦回调%@",newUrl);
        
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
        //NSLog(@"默认Data:%@",responseObject);
       
        
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

- (void)requestMoreData:(NSString*)cityId
{
    [SVProgressHUD showWithStatus:@"数据加载中..."];
  
    
    [XAFNetWork GET:cityId params:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        //NSLog(@"加载更多==%@",responseObject);
        NSArray* arr=responseObject[@"list"];
        
        if (!arr.count) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
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
  
    //return self.listArr.count;
     return self.listArr.count>0?self.listArr.count:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listArr.count>0) {
        HomeListCell* cell=[tableView dequeueReusableCellWithIdentifier:@"home"];
        //HomeListModel* model
        cell.model=self.listArr[indexPath.row];
        //cell.backgroundColor=[UIColor cyanColor];
        //self.isLikeStart=cell.likeCellBtn.islike;
        //cell.likeCellBtn.delegate=self;
        return cell;
    }
   
    static NSString* str =@"cell";
    UITableViewCell* cell= [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text=@"城市为开通";
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listArr.count>0) {
        return 220;
    }
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.listArr.count>0) {

    HomeDetailController* dVC=[[HomeDetailController alloc]init];
    
        
    HomeListModel* model=self.listArr[indexPath.row];
        
        dVC.chamber_id= model.chamber_id;
        dVC.userId=[XSaverTool objectForKey:UserIDKey];
    //dVC.model=model;
    
    dVC.likeStart=self.isLikeStart;

    [self.navigationController pushViewController:dVC animated:YES];
    }else
    {
        NSLog(@"点击了为开通");
    }
    
}

- (void)ClickLikeBtn:(BOOL)start
{
    NSLog(@"5555555=%d",start);
    self.isLikeStart=start;
    
}
- (void)saixuanId:(NSNotification *)notification
{
    NSString* newStr=notification.userInfo[@"areaUrl"];
    
    NSLog(@"homeNewStr===%@",newStr);
    [self requestData:newStr];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"Offset=%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y >= 0) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    /**
     * 导航条颜色渐变
     */;
    _offset = scrollView.contentOffset.y;//38,137,247
    [self.navigationController.navigationBar
     setBackgroundImage:[EncapsulationMethod createImageWithColor:[UIColor colorWithRed:0.97f green:0.97f blue:0.96f alpha:(_offset / 200)>0.99?0.99:(_offset / 200)]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar
     setShadowImage:[UIImage new]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar
     setBackgroundImage:[EncapsulationMethod createImageWithColor:[UIColor colorWithRed:0.97f green:0.97f blue:0.96f alpha:(_offset / 200)>0.99?0.99:(_offset / 200)]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar
     setShadowImage:[UIImage new]];
    
    //定位相关
    //定位服务管理对象初始化
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1000.0f;
    
    [self.locationManager requestWhenInUseAuthorization];
    //[self.locationManager requestAlwaysAuthorization];
    
    //开始定位
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationItem.title = @"依足";
    
}


//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    NSLog(@"viewWillAppear");
//    //定位相关
//    //定位服务管理对象初始化
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.delegate = self;
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    self.locationManager.distanceFilter = 1000.0f;
//
//    [self.locationManager requestWhenInUseAuthorization];
//    //[self.locationManager requestAlwaysAuthorization];
//
//    //开始定位
//    [self.locationManager startUpdatingLocation];
//}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    
    
    CLLocation *currLocation = [locations lastObject];
    //%3.5f是输出整数部分是3位，小数部分是5位的浮点数。
    //    self.txtLat.text = [NSString stringWithFormat:@"%3.5f",
    //                        currLocation.coordinate.latitude];
    //    self.txtLng.text = [NSString stringWithFormat:@"%3.5f",
    //currLocation.coordinate.longitude];
    
//    NSLog(@"定位回调中:lat===%@,long===%@",[NSString stringWithFormat:@"%3.5f",
//                                 currLocation.coordinate.latitude],[NSString stringWithFormat:@"%3.5f",
//                                                                    currLocation.coordinate.longitude]);
    
    NSLog(@"定位回调中:lat===%f,long===%f",
                                       currLocation.coordinate.latitude,
                                                                                                           currLocation.coordinate.longitude);
    
//    NSString* lat=[NSString stringWithFormat:@"%3.5f",
//                   currLocation.coordinate.latitude];
//    NSString* lon=[NSString stringWithFormat:@"%3.5f",
//                   currLocation.coordinate.longitude];
    NSString* lat=[NSString stringWithFormat:@"%f",
                                     currLocation.coordinate.latitude];
                       NSString* lon=[NSString stringWithFormat:@"%f",
                                      currLocation.coordinate.longitude];
    // 停止定位
 
    [self.locationManager stopUpdatingLocation];
    
    NSString* str=[NSString stringWithFormat:@"%@Mobile/Index/indexposition/personid/%@/lat/%@/lng/%@",Main_Server,[XSaverTool objectForKey:UserIDKey],lat,lon];
    NSLog(@"locanURL===%@",str);
    //http://47.104.18.18/index.php/Mobile/Index/indexposition/personid/
    //http://47.104.18.18/index.php/Mobile/Index/indexposition/personid/123/lat/22.28468/lng/114.15818
    [XAFNetWork GET:str params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位错误error: %@",error);
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        NSLog(@"Authorized");
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        NSLog(@"AuthorizedWhenInUse");
    } else if (status == kCLAuthorizationStatusDenied) {
        NSLog(@"Denied");
    } else if (status == kCLAuthorizationStatusRestricted) {
        NSLog(@"Restricted");
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"NotDetermined");
    }
    
}



//}
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
