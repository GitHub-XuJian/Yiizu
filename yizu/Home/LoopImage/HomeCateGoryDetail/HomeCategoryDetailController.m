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

- (void)viewDidAppear:(BOOL)animated
{
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tabScroce=[[NSMutableArray alloc]init];
    self.currentPage=1;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
   
    UINib* nib=[UINib nibWithNibName:@"HomeCateDetailCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"catecell"];
    
    [self.tableView registerClass:[HomeListSorryCell class] forCellReuseIdentifier:@"sorrycell"];
    
   
    [self.view addSubview:self.tableView];
    
    
    
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
#pragma mark-请求数据
- (void)loadData:(NSString*)url
{
    [_tabScroce removeAllObjects];
     [SVProgressHUD showWithStatus:@"数据加载中..."];
    //http://47.104.18.18/index.php/Mobile/Index/fortress/personid/人员id/insid/行业类别/data/城市id/page/分页数
    [XAFNetWork GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        NSArray* arr=responseObject[@"list"];
    
        for (NSDictionary* dic in arr) {
            HomeListModel* model =[HomeListModel ModelWithDict:dic];
            [_tabScroce addObject:model];
        }

        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        [self endRefresh];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self endRefresh];
        [SVProgressHUD dismiss];
    }];
}

#pragma mark-刷新
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
                [self loadData:newUrl];
            }];
    
            self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.currentPage+=1;
        NSString* url=@"";
        if (!IsLoginState)
        {
         url= [NSString stringWithFormat:@"%@Mobile/Index/fortress/personid/0/insid/%@/data/%@/page/%d",Main_Server,self.insid,self.cityId,self.currentPage];
        }else
        {
        url= [NSString stringWithFormat:@"%@Mobile/Index/fortress/personid/%@/insid/%@/data/%@/page/%d",Main_Server,[XSaverTool objectForKey:UserIDKey],self.insid,self.cityId,self.currentPage];
                   }
        DLog(@"上啦回调%@",url);
        [self moreData:url];

        
    }];
    self.tableView.mj_footer = footer;

    self.tableView.mj_footer.automaticallyHidden=YES;
}

- (void)moreData:(NSString*)url
{
    [SVProgressHUD showWithStatus:@"加载中"];
    
    [XAFNetWork GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray* listArr=responseObject[@"list"];
        
        for (NSDictionary* dic in listArr) {
            HomeListModel* model=[HomeListModel ModelWithDict:dic];
            [_tabScroce addObject:model];
        }

        [self.tableView reloadData];
        [self endRefresh];
        [SVProgressHUD dismiss];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"错误");
        [self endRefresh];
        [SVProgressHUD dismiss];
    }];
}

#pragma mark-结束刷新方法
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
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
        return 200;
    }
    return kSCREEN_HEIGHT-64;
   
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

//-(void)viewDidLayoutSubviews
//{
//    //[self viewDidLayoutSubviews];
//    self.tableView.estimatedRowHeight = 0;
//    self.tableView.estimatedSectionHeaderHeight = 0;
//    self.tableView.estimatedSectionFooterHeight = 0;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
