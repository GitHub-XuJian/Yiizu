//
//  HomeDetailController.m
//  yizu
//
//  Created by myMac on 2017/11/14.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeDetailController.h"
#import "HomeListModel.h"
#import "HomeDetailLoop.h"
#import "HomeDetailCell.h"

#import "HomeDetailFooter.h"

@interface HomeDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView* tabView;
//@property (nonatomic, strong) NSMutableArray* imaArr;
@end

@implementation HomeDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"商户详情";
    
    //_imaArr=[[NSArray alloc]init];
    self.tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
    self.tabView.delegate=self;
    self.tabView.dataSource=self;
    
    UINib* nib=[UINib nibWithNibName:@"HomeDetailCell" bundle:nil];
    [self.tabView registerNib:nib forCellReuseIdentifier:@"homedcell"];
    
    HomeDetailLoop* view=[[HomeDetailLoop alloc]initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, 200)];
    
    NSString* ima1=[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,_model.image1];
    NSString* ima2=[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,_model.image2];
    NSString* ima3=[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,_model.image3];
 
    view.ima1=ima1;
    view.ima2=ima2;
    view.ima3=ima3;
    

    [self.tabView setTableHeaderView:view];
    
    //HomeDetailFooter* footView=[[HomeDetailFooter alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tabView.frame), kSCREEN_WIDTH, 240)]; 
    HomeDetailFooter * foot=[HomeDetailFooter makeCustomFooterView];
    [self.tabView setTableFooterView:foot];
    foot.time=[NSString stringWithFormat:@"%@ - %@",_model.starttime,_model.endtime];
    foot.full=_model.full;
    foot.phone=_model.chammobile;
    foot.status=_model.status;
    foot.upvote=_model.upvote;
    foot.turvy=_model.Turvy;
    [self.view addSubview:self.tabView];
    
  
    
}

- (void)setModel:(HomeListModel *)model
{
    _model =model;
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeDetailCell* cell=[tableView dequeueReusableCellWithIdentifier:@"homedcell"];
    
    [cell.image1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,_model.image1]]];
     [cell.image2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,_model.image2]]];
     [cell.image3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,_model.image3]]];
    
    [cell.iconIma sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,_model.icon]]];
    
    cell.iconIma.layer.cornerRadius = 8;
    cell.iconIma.layer.masksToBounds = YES;
    
    cell.titleLab.text=_model.chambername;
    cell.upLab.text=[NSString stringWithFormat:@"|排名 : %@ | 已售 : %@",_model.up,_model.obtained];
   // cell.chamberjjLab.text=_model.chamberjj;
  
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
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
