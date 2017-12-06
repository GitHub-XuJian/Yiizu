//
//  ActivityPageController.m
//  yizu
//
//  Created by myMac on 2017/11/8.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ActivityPageController.h"
#import "ActivityCell.h"
#import "ActivityLsitModel.h"
#import "ActivityWebController.h"
#import "CustomCellScrollView.h"
#import "ScrollImaView.h"
#import "SmallActivityListModel.h"

@interface ActivityPageController ()<myViewidDelegate,UIScrollViewDelegate,ScrmyaaaDelegate>

@property (nonatomic,strong) NSMutableArray* tabSource;
    
@end

@implementation ActivityPageController

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear: animated];
//    self.navigationController.navigationBarHidden=YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    _tabSource=[[NSMutableArray alloc]init];
   
    NSString* str = [NSString stringWithFormat:@"%@Mobile/Bridge/Brigelist/",Main_Server];
    //NSString* str=@"http://47.104.18.18/index.php/Mobile/Bridge/Brigelist/";
    
    [self loadData:str];
    
    [self setupRefresh];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    // 隐藏导航条
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)loadData:(NSString*)str
{
    
    [_tabSource removeAllObjects];
    
     [SVProgressHUD showWithStatus:@"数据加载中..."];
   //http://47.104.18.18/index.php/Mobile/Bridge/Brigelist/
    [XAFNetWork GET:str params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       
        for (NSDictionary* dic in responseObject) {
            //NSLog(@"dataListLoop:%@",responseObject);
            ActivityLsitModel * model=[ActivityLsitModel modelWithDict:dic];
            [_tabSource addObject:model];
        }
      
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    }];
}
//【下拉刷新】【上拉加载】
-(void)setupRefresh{
    MJRefreshNormalHeader *header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
         NSString* str = [NSString stringWithFormat:@"%@Mobile/Bridge/Brigelist/",Main_Server];
        [self loadData:str];
        
    }];
    
    self.tableView.mj_header = header;
    
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//     return _tabSource.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
//    ActivityLsitModel* model=_tabSource[section];
//    return model.pic.count;
    return _tabSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellA" forIndexPath:indexPath];
    
    cell.customScrollView.ScrDelegate=self;
    ActivityLsitModel* model=_tabSource[indexPath.row];
    
    cell.model=model;
    
    return cell;
    
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了活动列表:%ld",(long)indexPath.row);
    
    ActivityLsitModel* model=_tabSource[indexPath.row];
    //model.activityid
    NSLog(@"活动%@",model.activityid);
    ActivityWebController* web=[[ActivityWebController alloc]init];
    
    web.activiId=model.activityid;
    [self.navigationController pushViewController:web animated:YES];
    
    
}

- (void)ImaaActid:(NSString *)actid
{
    ActivityWebController* web=[[ActivityWebController alloc]init];
    //ActivityLsitModel* model=_tabSource[HeaderView.tag];
    NSLog(@"活动小图id=%@",actid);
    web.activiId=actid;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame=CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-50);
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
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
