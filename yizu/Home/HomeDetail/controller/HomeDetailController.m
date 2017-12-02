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

#import  <MapKit/MapKit.h>
#import "CellBtn.h"
#import "favoriteBtn.h"



@interface HomeDetailController ()<UITableViewDelegate,UITableViewDataSource,HomeDetailFooterDelegate>
@property (nonatomic, strong) UITableView* tabView;
@property (nonatomic, strong) NSMutableArray* imaArr;
@end

@implementation HomeDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"商户详情";
    
    _imaArr=[[NSMutableArray alloc]init];
    self.tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
    self.tabView.delegate=self;
    self.tabView.dataSource=self;
    UINib* nib=[UINib nibWithNibName:@"HomeDetailCell" bundle:nil];
    [self.tabView registerNib:nib forCellReuseIdentifier:@"homedcell"];
    
    HomeDetailLoop* view=[[HomeDetailLoop alloc]initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, 200)];
    
    NSString* ima1=[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,_model.image1];
    [_imaArr addObject:ima1];
    NSString* ima2=[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,_model.image2];
    [_imaArr addObject:ima2];
    NSString* ima3=[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,_model.image3];
    [_imaArr addObject:ima3];
    view.imaArr=_imaArr;
    

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
    foot.delegate=self;
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
    
    //cell.userInteractionEnabled = NO;
    //选中行无色（没有点击的状态样式）
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  
    [cell.image1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,_model.image1]]];
     [cell.image2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,_model.image2]]];
     [cell.image3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,_model.image3]]];
    
    [cell.iconIma sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,_model.icon]]];
    
    cell.iconIma.layer.cornerRadius = 8;
    cell.iconIma.layer.masksToBounds = YES;
    
    cell.titleLab.text=_model.chambername;
    cell.upLab.text=[NSString stringWithFormat:@"|排名 : %@ | 已售 : %@",_model.up,_model.obtained];
   // cell.chamberjjLab.text=_model.chamberjj;
  
 
    cell.likeBtn.chambername=_model.chambername;
    cell.favBtn.chambername=_model.chambername;
   
    
if (_model.status) {
            cell.likeBtn.islike=YES;
        }else
        {
            cell.likeBtn.islike=NO;
        }
    
    cell.likeBtn.likeCount=_model.upvote.integerValue;
   
    
        if (_model.Turvy) {
            cell.favBtn.issc=YES;
        }else
        {
            cell.favBtn.issc=NO;
        }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

- (void)HomeDetailFooterView:(HomeDetailFooter *)footView
{

    //起点
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    //CLLocationCoordinate2D desCorrdinate = CLLocationCoordinate2DMake(self.destinationCoordinate.latitude, self.destinationCoordinate.longitude);
  
   
    CLLocationCoordinate2D des= CLLocationCoordinate2DMake(_model.lat.floatValue, _model.lng.floatValue);
    //终点
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:des addressDictionary:nil]];
    toLocation.name=_model.full;
    //默认驾车
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                   launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                   MKLaunchOptionsMapTypeKey:[NSNumber numberWithInteger:MKMapTypeStandard],
                                   MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
   
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
