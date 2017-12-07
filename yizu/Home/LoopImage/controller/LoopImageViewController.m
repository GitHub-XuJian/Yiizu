//
//  LoopImageViewController.m
//  yizu
//
//  Created by myMac on 2017/10/25.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "LoopImageViewController.h"
#import "UIImageView+AFNetworking.h"
#import "HomAreaBtnController.h"
#import "SDCycleScrollView.h"
#import "HomeCategoryCell.h"
#import "HomeCategoryCell.h"
#import "HomeCategoryModel.h"
#import "HomeCategoryDetailController.h"
#import "PopMenuView.h"


@interface LoopImageViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,HomAreaBtnDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btn;


@property (strong, nonatomic) UICollectionView* collectionView;

@property (strong, nonatomic) NSMutableArray* loopArr;
@property (strong, nonatomic) NSMutableArray* cateArr;


@property (strong, nonatomic) UIView*  grayColorView;

@property (strong, nonatomic) UIView* btnView;


@property (copy, nonatomic) NSString* areaid;
@property (copy, nonatomic) NSString* areaName;

@end

@implementation LoopImageViewController


- (NSMutableArray *)loopArr
{
    if (_loopArr==nil) {
        _loopArr=[[NSMutableArray alloc]init];
    }
    return _loopArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //设置第一次点击区域按钮
    self.cityID=@"73";
   
    
    
    //通知接受数据之前不崩现在崩
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(massageCityId:) name:@"nameId" object:nil];

    NSString*  url=[NSString stringWithFormat:@"%@Mobile/Index/index_Slideshow",Main_Server];
    [XAFNetWork GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //DLog(@"ima====%@",responseObject);
        NSArray* arr=responseObject[@"list"];
        
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString* imaUrl=[NSString stringWithFormat:@"%@Public/img/img/%@",Main_ServerImage,arr[idx]];
            
            [self.loopArr addObject:imaUrl];
        }];
        
        [self initCycleScrollView];
       
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
                DLog(@"出错了");
        [SVProgressHUD dismiss];

        [SVProgressHUD showErrorWithStatus:@"出错了"];

    }];
    
    
    
    
}
- (void)massageCityId:(NSNotification *)notification
{
    
    self.cityID=notification.userInfo[@"cityId"];
    
}
- (void)initCycleScrollView
{
    //SDCycleScrollView* cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 210) delegate:self placeholderImage:nil];
    SDCycleScrollView* cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 240) delegate:self placeholderImage:nil];
    cycleScrollView.imageURLStringsGroup=self.loopArr;
    cycleScrollView.autoScrollTimeInterval=2.0;
    cycleScrollView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    [self.view addSubview:cycleScrollView];
    
    //行业类别
    //http://www.xdfishing.cn/index.php/Mobile/Index/indexindustry/
    _cateArr=[[NSMutableArray alloc]init];
    [XAFNetWork GET:@"http://www.xdfishing.cn/index.php/Mobile/Index/indexindustry/" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //DLog(@"hangye====%@",responseObject);
        for (NSDictionary* dic in responseObject) {
            HomeCategoryModel* model=[HomeCategoryModel modelWithDict:dic];
            [_cateArr addObject:model];
        }
       
        [self.collectionView reloadData];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"出错了");
        [SVProgressHUD dismiss];
        
        [SVProgressHUD showErrorWithStatus:@"出错了"];
        
    }];
    [self createCollection:cycleScrollView];
}


- (void)createCollection:(SDCycleScrollView*)SDScrollView
{
    
    UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc]init];
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(SDScrollView.frame), kSCREEN_WIDTH, 180) collectionViewLayout:flowLayout];

  
    
    CGFloat itemW = (kSCREEN_WIDTH -160-40)/5;
    CGFloat itemH = (self.collectionView.frame.size.height-20-40)/2;
   // DLog(@"%@",NSStringFromCGRect(self.view.frame));
    
    flowLayout.itemSize=CGSizeMake(itemW, itemH);
    flowLayout.minimumLineSpacing=40;//竖间距
   
    flowLayout.minimumInteritemSpacing=20;
    
    
    flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset=UIEdgeInsetsMake(20, 20, 20, 20);
    

    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator=NO;
    [self.collectionView registerClass:[HomeCategoryCell class] forCellWithReuseIdentifier:@"catecell"];

    [self.view addSubview:self.collectionView];
    
    //灰色背景
    [self createBackView];
    
}

- (void)createBackView
{
    self.grayColorView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), kSCREEN_WIDTH, 5)];
    self.grayColorView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.grayColorView];
    
    [self createBtnView];
}

- (void)createBtnView
{
    self.btnView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.grayColorView.frame), kSCREEN_WIDTH, 30)];
    //self.btnView.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:self.btnView];
    
    CGFloat x=50;
    CGFloat W=(kSCREEN_WIDTH-100)/3;
    NSArray* btnTitle=@[@"离我最近",@"热门商家",@"区域分布"];
    for (int i=0; i<3; i++) {
        UIButton* btn=[[UIButton alloc]init];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn setTitle:btnTitle[i] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:13];
        btn.frame=CGRectMake(i*(W+x), 0, W, 30);
        //                                                                                                       [btn addTarget:self action:@selector(btnViewAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            btn.selected=YES;
        }
        btn.tag=100+i;
        
        [self.btnView addSubview:btn];
    }
}

- (void)btnAction:(UIButton *)sender
{
    
    sender.selected=YES;
    
    NSArray* btns=self.btnView.subviews;
    
    for (UIButton* btn in btns) {
        if (btn.tag!=sender.tag) {
            //判断一个对象是不是按钮（某个类）
            if (![btn isMemberOfClass:[UIButton class]]) {
                //continue跳出循环继续xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                continue;
            }
            btn.selected=NO;
        }
    }
    
    if ([sender.currentTitle isEqualToString:@"离我最近"]) {
       
         NSString* url=@"";
        if (self.areaid) {
            
            url=[NSString stringWithFormat:@"%@Mobile/Index/index_area/data/%@/area/%@/personid/%@/sequence/0/page/1/",Main_Server,self.cityID,self.areaid,[XSaverTool objectForKey:UserIDKey]];
            DLog(@"点击了区域按钮aaa\n%@",url);
        }else{
            
            url=[NSString stringWithFormat:@"%@Mobile/Index/index_Chamber/data/%@/personid/%@/sequence/0/page/1/",Main_Server,self.cityID,[XSaverTool objectForKey:UserIDKey]];
            DLog(@"没点区域按钮%@\n",url);
        }
        
        NSDictionary* dict=@{@"areaId":@"1",@"areaUrl":url};
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"saixuan" object:nil userInfo:dict];
    }else if ([sender.currentTitle isEqualToString:@"热门商家"])
    {
        NSString* url=@"";
        
        if (self.areaid) {
            
            DLog(@"点击了区域按钮aaa");
            url=[NSString stringWithFormat:@"%@Mobile/Index/index_area/data/%@/area/%@/personid/%@/sequence/1/page/1/",Main_Server,self.cityID,self.areaid,[XSaverTool objectForKey:UserIDKey]];
            
        }else{
            url=[NSString stringWithFormat:@"%@Mobile/Index/index_Chamber/data/%@/personid/%@/sequence/1/page/1/",Main_Server,self.cityID,[XSaverTool objectForKey:UserIDKey]];
            DLog(@"没点区域按钮");
        }
        
        NSDictionary* dict=@{@"areaId":@"1",@"areaUrl":url};
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"saixuan" object:nil userInfo:dict];
    }else
    {
      
        HomAreaBtnController* aVC=[[HomAreaBtnController alloc]init];
        aVC.cityId=self.cityID;
        aVC.delegate=self;
        UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:aVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
}



#pragma mark-UIcollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _cateArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCategoryCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"catecell" forIndexPath:indexPath];
    //cell.backgroundColor=[UIColor cyanColor];
    
    cell.model=_cateArr[indexPath.item];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCategoryModel* model=_cateArr[indexPath.item];
    
    HomeCategoryDetailController* HCDVC=[[HomeCategoryDetailController alloc]init];
    
    HCDVC.cateTitle=model.tradename;
    HCDVC.insid=model.insid;
    HCDVC.cityId=self.cityID;
    //http://www.xdfishing.cn/index.php/Mobile/Index/fortress/personid/人员id/insid/行业类别/data/城市id/page/分页数
    [self.navigationController pushViewController:HCDVC animated:YES];
}

- (void)HomAreaBtnTitleId:(NSString *)title areaId:(NSString *)aid
{
    self.areaid=aid;
    self.areaName=title;
    DLog(@"地区==%@",title);
    
    UIButton* btn= [self.btnView viewWithTag:102];
    [btn setTitle:title forState:UIControlStateNormal];
    
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
