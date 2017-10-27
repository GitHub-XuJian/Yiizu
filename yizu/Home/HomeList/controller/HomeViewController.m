//
//  HomeViewController.m
//  yizu
//
//  Created by myMac on 2017/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeListCell.h"
#import "XAFNetWork.h"
#import "HomeCityBtnController.h"
#import "HomeListModel.h"

#import "LoopImageViewController.h"

@interface HomeViewController ()<HomeCityBtnDelegate>
@property(nonatomic, strong)NSArray* listArr;
@property(nonatomic, strong)UIButton* navBtn;



@end

@implementation HomeViewController

- (void)setListArr:(NSArray *)listArr
{
    _listArr=listArr;
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"依足";
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"沈阳" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 70, 60)];
    [btn addTarget:self action:@selector(navBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* btn2=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=btn2;
    self.navBtn=btn;

    [HomeListModel HomeListWithUrl:@"http://123.207.158.228/yizu/index.php/Mobile/Index/index_area/data/73/area/845/page/1" success:^(NSArray *array) {
        
        self.listArr=array;
    } error:^{
        
    }];
    
}

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
    
    NSDictionary *dict = @{@"name":title, @"cityId":url};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"nameId" object:nil userInfo:dict];
    
    
    //postNotificationName:之后的参数就是这个通知的名字，要和要和接收者中的名字一样，才能让接收者正确接收。
    //object：接收对象
    //userInfo: 携带的参数，在例子中我携带了一个字典，因为有时候我们要传递的参数不只是一个，所以把东西全部放在通知里面，在接收者中，根据字典里面的键来取出里面的值。
   
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
