//
//  ActivityDetailController.m
//  yizu
//
//  Created by myMac on 2017/11/13.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ActivityDetailController.h"
#import "ActivityDetailLoopView.h"
#import "ActivityDetailCell.h"
#import "ActivityDetailListModel.h"
#import "HomeDetailController.h"

#import "ActivityWebController.h"

@interface ActivityDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView* tabView;

@property (nonatomic, strong) NSMutableArray* listArr;

@end

@implementation ActivityDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
    self.tabView.delegate=self;
    self.tabView.dataSource=self;
    //self.tabView.separatorStyle = NO;//隐藏cell分割线
    ActivityDetailLoopView* headerView=[[ActivityDetailLoopView alloc]initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, 300)];
    headerView.idq=self.idq;
    [self.tabView setTableHeaderView:headerView];
    UINib* nib=[UINib nibWithNibName:@"ActivityDetailCell" bundle:nil];
    [self.tabView registerNib:nib forCellReuseIdentifier:@"dcell"];
    [self.view addSubview:self.tabView];
    
    [self loadData];
    
    [self setupRefresh];
    // Do any additional setup after loading the view.
}

- (void)loadData
{
    _listArr =[[NSMutableArray alloc]init];
    
    [XAFNetWork GET:[NSString stringWithFormat:@"%@Mobile/Bridge/Bridgelistlist/city_id/%@/personid/3",Main_Server,self.townId] params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"aclist:===%@",responseObject);
        
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ActivityDetailListModel* model=[ActivityDetailListModel modelWithDict:obj];
            [_listArr addObject:model];
        }];
        [self.tabView reloadData];
        [self.tabView.mj_header endRefreshing];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tabView.mj_header endRefreshing];
    }];
}

//【下拉刷新】【上拉加载】
-(void)setupRefresh{
    MJRefreshNormalHeader *header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    self.tabView.mj_header = header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ActivityDetailCell* cell=[tableView dequeueReusableCellWithIdentifier:@"dcell"];
 
    cell.model=_listArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ActivityWebController* web=[[ActivityWebController alloc]init];
    ActivityDetailListModel* model=_listArr[indexPath.row];
    web.activiId=model.activityid;
   
    [self.navigationController pushViewController:web animated:YES];
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
