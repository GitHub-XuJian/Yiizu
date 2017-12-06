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

#import "HomeDetailModel.h"
#import "HomeDetailScrollView.h"
#import "HomeDetailImaView.h"


@interface HomeDetailController ()<UITableViewDelegate,UITableViewDataSource,HomeDetailFooterDelegate,HomeDetailScrollViewDelegate>
@property (nonatomic, strong) UITableView* tabView;
@property (nonatomic, strong) NSMutableArray* imaArr;



@property (nonatomic, strong) NSMutableArray* detailArr;

@property (nonatomic, strong) HomeDetailFooter* footView;
@property (nonatomic, strong) HomeDetailLoop* loopView;

//点击放大模糊背景
@property (nonatomic, strong) UIButton* backBtn;
//记录原始frame
@property (nonatomic,assign)CGRect imaFrame;
@property (nonatomic, strong) UIImageView* imaV;
@end

@implementation HomeDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _detailArr=[[NSMutableArray alloc]init];
    [self loadData];
    
    self.navigationItem.title=@"商户详情";
    
    _imaArr=[[NSMutableArray alloc]init];
    self.tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
    self.tabView.delegate=self;
    self.tabView.dataSource=self;
    UINib* nib=[UINib nibWithNibName:@"HomeDetailCell" bundle:nil];
    [self.tabView registerNib:nib forCellReuseIdentifier:@"homedcell"];
    
    HomeDetailLoop* view=[[HomeDetailLoop alloc]initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, 200)];
    
    

    [self.tabView setTableHeaderView:view];
    self.loopView=view;
    //HomeDetailFooter* footView=[[HomeDetailFooter alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tabView.frame), kSCREEN_WIDTH, 240)]; 
    HomeDetailFooter * foot=[HomeDetailFooter makeCustomFooterView];
    [self.tabView setTableFooterView:foot];
        foot.delegate=self;
    self.footView=foot;
    [self.view addSubview:self.tabView];
    
  
    
}

- (void)loadData
{
    [XAFNetWork GET:[NSString stringWithFormat:@"%@Mobile/Index/connector/chamber_id/%@/personid/%@",Main_Server,_chamber_id,_userId] params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"responseObject==%@",responseObject);
        
        HomeDetailModel* model=[HomeDetailModel ModelWithDict:responseObject];
        [_detailArr addObject:model];
        [self.tabView reloadData];
        [self updateUI:model];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)updateUI:(HomeDetailModel*)model
{
    NSString* str =@"";
    for (int i=0; i<model.lun.count; i++) {
        str = [NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,model.lun[i]];
        [_imaArr addObject:str];
    }
    self.loopView.imaArr=_imaArr;
//
    self.footView.time=[NSString stringWithFormat:@"%@ - %@",model.starttime,model.endtime];
    self.footView.full=model.full;
    self.footView.phone=model.chammobile;
    self.footView.status=model.status;
    self.footView.upvote=model.upvote;
    self.footView.turvy=model.Turvy;
}
- (void)setModel:(HomeListModel *)model
{
    _model =model;
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //return 1;
    return _detailArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeDetailCell* cell=[tableView dequeueReusableCellWithIdentifier:@"homedcell"];
    HomeDetailModel* model = _detailArr[indexPath.row];
    //cell.userInteractionEnabled = NO;
    //选中行无色（没有点击的状态样式）
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.iconIma.layer.cornerRadius = 8;
    cell.iconIma.layer.masksToBounds = YES;
    [cell.iconIma sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,model.icon]]];
    cell.titleLab.text=model.chambername;
    cell.upLab.text=[NSString stringWithFormat:@"%@ | 排名 : %@",model.city_id,model.up];
    cell.chamberjjLab.text=model.chamberjj;
    
    
    cell.likeBtn.chambername=model.chambername;
    cell.favBtn.chambername=model.chambername;
    
    
    if (model.status) {
        cell.likeBtn.islike=YES;
    }else
    {
        cell.likeBtn.islike=NO;
    }
    
    cell.likeBtn.likeCount=model.upvote.integerValue;
    
    
    if (model.Turvy) {
        cell.favBtn.issc=YES;
    }else
    {
        cell.favBtn.issc=NO;
    }
    
    cell.homeScrollview.Amodel=model;
    cell.homeScrollview.homeDelegate=self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

- (void)HomeDetailFooterView:(HomeDetailFooter *)footView
{
    HomeDetailModel* model = _detailArr[0];

    
    //起点
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    //CLLocationCoordinate2D desCorrdinate = CLLocationCoordinate2DMake(self.destinationCoordinate.latitude, self.destinationCoordinate.longitude);
  
   
    CLLocationCoordinate2D des= CLLocationCoordinate2DMake(model.lat.floatValue, model.lng.floatValue);
    
    //终点
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:des addressDictionary:nil]];
    toLocation.name=model.full;
    NSLog(@"导航终点==%@",model.full);
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

- (void)HomeDetail:(HomeDetailImaView*)ima
{
    self.imaV = [[UIImageView alloc] init];
    self.imaV.image =ima.image;
    /**
     * 获取当前视图在屏幕中的位置
     */
    CGRect rect=[ima convertRect: ima.bounds toView:[[[UIApplication sharedApplication] delegate] window]];
    self.imaV.frame = rect;
//    self.imaV=ima;
    NSLog(@"imaFrame==%@",NSStringFromCGRect(ima.frame));// imaFrame=={{10, 0}, {128, 95}}
    //self.isBig=YES;
    //记录一下头像按钮的原始frame
    self.imaFrame=rect;
    //创建大小与屏幕大小一样的按钮，把这个按钮作为阴影
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=self.view.frame;
    btn.backgroundColor=[UIColor blackColor];
    btn.alpha=0.0;
    [btn addTarget:self action:@selector(smallBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.backBtn=btn;

    [self.view bringSubviewToFront:ima];
    [self.view addSubview:self.imaV];

    CGFloat newW=self.view.frame.size.width;
    CGFloat newH=newW;
    CGFloat newY=(self.view.frame.size.height-self.view.frame.size.width)*0.5;
    [UIView animateWithDuration:0.2 animations:^{

        self.imaV.frame=CGRectMake(0,newY,newW, newH);
        self.backBtn.alpha=0.5;
    }];
}

//还原放大图片的按钮方法
-(void)smallBtn
{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.imaV.frame=self.imaFrame;
        self.backBtn.alpha=0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.backBtn removeFromSuperview];
            [self.imaV removeFromSuperview];
            self.backBtn=nil;
            self.imaV=nil;
        }
    }];
    //self.isBig=NO;
    
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
