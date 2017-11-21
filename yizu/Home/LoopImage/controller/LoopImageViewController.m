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

@interface LoopImageViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btn;


@property (strong, nonatomic) UICollectionView* collectionView;

@property (strong, nonatomic) NSMutableArray* loopArr;


@property (assign, nonatomic)int currentNumber;

@end

@implementation LoopImageViewController
- (IBAction)btnAction:(id)sender
{
 
    NSLog(@"点击了区域按钮%@",self.cityID);
    HomAreaBtnController* aVC=[[HomAreaBtnController alloc]init];
    aVC.cityId=self.cityID;
    UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:aVC];
    [self presentViewController:nav animated:YES completion:nil];
    
    
    
}

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
   
    
    
    //通知接受数据
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(massageCityId:) name:@"nameId" object:nil];

    NSString*  url=[NSString stringWithFormat:@"%@Mobile/Index/index_Slideshow",Main_Server];
    [XAFNetWork GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"ima====%@",responseObject);
        NSArray* arr=responseObject[@"list"];
        
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString* imaUrl=[NSString stringWithFormat:@"%@Public/img/img/%@",Main_ServerImage,arr[idx]];
            
            [self.loopArr addObject:imaUrl];
        }];
        
        [self initCycleScrollView];
       
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"出错了");
        [SVProgressHUD dismiss];

        [SVProgressHUD showErrorWithStatus:@"出错了"];

    }];
    
    
    
    
}

- (void)initCycleScrollView
{
    SDCycleScrollView* cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180) delegate:self placeholderImage:nil];
    cycleScrollView.imageURLStringsGroup=self.loopArr;
    cycleScrollView.autoScrollTimeInterval=2.0;
    cycleScrollView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    [self.view addSubview:cycleScrollView];
    
    //行业类别
    
    [self createCollection:cycleScrollView];
}


- (void)createCollection:(SDCycleScrollView*)SDScrollView
{

    UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.itemSize=CGSizeMake(30, 30);
    flowLayout.minimumLineSpacing=2;
    flowLayout.minimumInteritemSpacing=2;
    flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(SDScrollView.frame), kSCREEN_WIDTH, 150) collectionViewLayout:flowLayout];
    
    
    
    [self.view addSubview:self.collectionView];
    
}
#pragma mark-scrollView相关设置

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
