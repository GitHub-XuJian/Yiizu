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

#import "HomeListSorryCell.h"

@interface HomeCategoryDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* tabScroce;

//页数
@property(nonatomic,assign)int currentPage;

@end

@implementation HomeCategoryDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentPage=1;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    UINib* nib=[UINib nibWithNibName:@"HomeCateDetailCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"catecell"];
    
    [self.tableView registerClass:[HomeListSorryCell class] forCellReuseIdentifier:@"sorrycell"];
    
   
    [self.view addSubview:self.tableView];
    
    _tabScroce=[[NSMutableArray alloc]init];
    
    NSString* newUrl=@"";
    if (!IsLoginState)
    {
        newUrl=[NSString stringWithFormat:@"%@Mobile/Index/fortress/personid/0/insid/%@/data/%@/page/1",Main_Server,self.insid,self.cityId];
    }else
    {
        newUrl= [NSString stringWithFormat:@"%@Mobile/Index/fortress/personid/%@/insid/%@/data/%@/page/1",Main_Server,[XSaverTool objectForKey:UserIDKey],self.insid,self.cityId];
    }
    
    DLog(@"行业类别列表%@",newUrl);
    [self loadData:newUrl];
    
    [self setupRefresh];
    // Do any additional setup after loading the view.
}

- (void)loadData:(NSString*)url
{
    [_tabScroce removeAllObjects];
     [SVProgressHUD showWithStatus:@"数据加载中..."];
    //http://47.104.18.18/index.php/Mobile/Index/fortress/personid/人员id/insid/行业类别/data/城市id/page/分页数
    [XAFNetWork GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //DLog(@"url===%@",[NSString stringWithFormat:@"%@Mobile/Index/fortress/personid/0/insid/%@/data/%@/page/1",Main_Server,self.insid,self.cityId]);
        //DLog(@"catehome===%@",responseObject);
        //和首页数据类型一样
        NSArray* arr=responseObject[@"list"];
       

        for (NSDictionary* dic in arr) {
            HomeListModel* model =[HomeListModel ModelWithDict:dic];
            
                        [_tabScroce addObject:model];
        }
        // DLog(@"catehome===%lu",(unsigned long)_tabScroce.count);
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    }];
}

//【下拉刷新】【上拉加载】
-(void)setupRefresh{
    MJRefreshNormalHeader *header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSString* newUrl=@"";
        if (!IsLoginState)
        {
            newUrl=[NSString stringWithFormat:@"%@Mobile/Index/fortress/personid/0/insid/%@/data/%@/page/1",Main_Server,self.insid,self.cityId];
        }else
        {
            newUrl= [NSString stringWithFormat:@"%@Mobile/Index/fortress/personid/%@/insid/%@/data/%@/page/1",Main_Server,[XSaverTool objectForKey:UserIDKey],self.insid,self.cityId];
        }
        
        DLog(@"行业类别列表%@",newUrl);
        [self loadData:newUrl];
        
    }];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer  =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.currentPage+=1;
        NSString* newUrl=@"";
        if (!IsLoginState)
        {
            
            newUrl= [NSString stringWithFormat:@"%@Mobile/Index/fortress/personid/0/insid/%@/data/%@/page/%d",Main_Server,self.insid,self.cityId,self.currentPage];
        }else
        {
            newUrl= [NSString stringWithFormat:@"%@Mobile/Index/fortress/personid/%@/insid/%@/data/%@/page/%d",Main_Server,[XSaverTool objectForKey:UserIDKey],self.insid,self.cityId,self.currentPage];
        }
        
        [self requestMoreData:newUrl];
        DLog(@"上啦回调%@",newUrl);
        
    }];
    self.tableView.mj_footer = footer;
    /////////////////////////////////
    self.tableView.mj_footer.automaticallyHidden=YES;
}

- (void)requestMoreData:(NSString*)url
{
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    
    [XAFNetWork GET:url params:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        //DLog(@"加载更多==%@",responseObject);
        NSArray* arr=responseObject[@"list"];
        self.tableView.tableFooterView.hidden=YES;
        
        
            if (!arr.count) {
                
                
                self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
              
            }
            
        
        
        
        
        for (NSDictionary* dic in arr) {
            HomeListModel* model =[HomeListModel ModelWithDict:dic];
            
            [_tabScroce addObject:model];
        }
        // DLog(@"catehome===%lu",(unsigned long)_tabScroce.count);
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    }];
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
    //return _tabScroce.count;
    return _tabScroce.count>0?_tabScroce.count:1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (!_tabScroce.count) {
        static NSString* str =@"sorrycell";
        HomeListSorryCell* cell= [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell=[[HomeListSorryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        //cell.userInteractionEnabled = NO;
        //选中行无色（没有点击的状态样式）
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    HomeCateDetailCell* cell=[tableView dequeueReusableCellWithIdentifier:@"catecell" forIndexPath:indexPath];
    
    cell.model=_tabScroce[indexPath.row];
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return 200;
    
    if (_tabScroce.count>0) {
        return 220;
    }
    return kSCREEN_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (_tabScroce.count>0) {
        
        HomeDetailController* dVC=[[HomeDetailController alloc]init];
        
        HomeListModel* model=_tabScroce[indexPath.row];
        
        
        
        dVC.chamber_id= model.chamber_id;
        dVC.userId=[XSaverTool objectForKey:UserIDKey];
        
        
        [self.navigationController pushViewController:dVC animated:YES];
    }else
    {
        DLog(@"点击了为开通");
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
