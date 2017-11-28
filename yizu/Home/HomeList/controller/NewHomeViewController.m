//
//  NewHomeViewController.m
//  yizu
//
//  Created by myMac on 2017/11/27.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "NewHomeViewController.h"
#import "HomeListModel.h"
#import "HomeCateDetailCell.h"

@interface NewHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* listArr;
@property(nonatomic,assign)int currentPage;

@end

@implementation NewHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    UINib* nib=[UINib nibWithNibName:@"HomeCateDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"catecell"];
    
    [self.tableView addSubview:self.tableView];
    
    self.currentPage=1;
   
    NSString*  newUrl=[NSString stringWithFormat:@"%@Mobile/Index/index_Chamber/data/73/page/%d",Main_Server,self.currentPage];
    [self requestData:newUrl];
    
    // Do any additional setup after loading the view.
}

- (void)requestData:(NSString*)url
{
    _listArr=[[NSMutableArray alloc]init];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    [XAFNetWork GET:url params:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
       
        NSArray* arr=responseObject[@"list"];
        for (NSDictionary* dic in arr) {
            HomeListModel* model=[HomeListModel ModelWithDict:dic];
            
            [_listArr addObject:model];
            
        }
        //}
        
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        //[self endRefresh];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        //[self endRefresh];
        [SVProgressHUD dismiss];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeCateDetailCell* cell =[tableView dequeueReusableCellWithIdentifier:@"catecell"];
    
    cell.model=_listArr[indexPath.row];
    
    
    return cell;
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
