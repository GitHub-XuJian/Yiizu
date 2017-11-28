//
//  HomeCategoryDetailController.m
//  yizu
//
//  Created by myMac on 2017/11/21.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeCategoryDetailController.h"
#import "HomeCateDetailCell.h"

#import "HomeListModel.h"

#import "HomeDetailController.h"

@interface HomeCategoryDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* tabScroce;

@end

@implementation HomeCategoryDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    UINib* nib=[UINib nibWithNibName:@"HomeCateDetailCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"catecell"];
    
    [self.view addSubview:self.tableView];
    
    _tabScroce=[[NSMutableArray alloc]init];
    [self loadData];
    
    //[self setupRefresh];
    // Do any additional setup after loading the view.
}

- (void)loadData
{
    
    //http://47.104.18.18/index.php/Mobile/Index/fortress/personid/人员id/insid/行业类别/data/城市id/page/分页数
    [XAFNetWork GET:[NSString stringWithFormat:@"%@Mobile/Index/fortress/personid/0/insid/%@/data/%@/page/1",Main_Server,self.insid,self.cityId] params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"url===%@",[NSString stringWithFormat:@"%@Mobile/Index/fortress/personid/0/insid/%@/data/%@/page/1",Main_Server,self.insid,self.cityId]);
        //NSLog(@"catehome===%@",responseObject);
        //和首页数据类型一样
        NSArray* arr=responseObject[@"list"];
      

        for (NSDictionary* dic in arr) {
            HomeListModel* model =[HomeListModel ModelWithDict:dic];
            
                        [_tabScroce addObject:model];
        }
        // NSLog(@"catehome===%lu",(unsigned long)_tabScroce.count);
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

//【下拉刷新】【上拉加载】
-(void)setupRefresh{
    MJRefreshNormalHeader *header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    self.tableView.mj_header = header;
}

- (void)setCateTitle:(NSString *)cateTitle
{
    _cateTitle=cateTitle;
    
    self.navigationItem.title=cateTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tabScroce.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    HomeCateDetailCell* cell=[tableView dequeueReusableCellWithIdentifier:@"catecell" forIndexPath:indexPath];
   
    cell.model=_tabScroce[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetailController* dVC=[[HomeDetailController alloc]init];
    
    HomeListModel* model=_tabScroce[indexPath.row];
    
    dVC.model=model;
    
    [self.navigationController pushViewController:dVC animated:YES];
    
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
