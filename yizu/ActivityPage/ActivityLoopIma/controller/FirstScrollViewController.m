//
//  FirstScrollViewController.m
//  yizu
//
//  Created by myMac on 2017/11/7.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "FirstScrollViewController.h"
#import "SDCycleScrollView.h"
#import "XAFNetWork.h"
#import "ActivityPageModel.h"

#import "ActivityDetailController.h"




@interface FirstScrollViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong)NSMutableArray* loopIma;
@property (nonatomic, strong)SDCycleScrollView* SDCScrollView;
@property (nonatomic, strong)NSMutableArray* cityArr;


@end

@implementation FirstScrollViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    _loopIma=[[NSMutableArray alloc]init];
    _cityArr=[[NSMutableArray alloc]init];
    
    
    [self loadData];
    [self loadCityData];
    
    

    
    // Do any additional setup after loading the view.
}

- (void)loadData
{
    [XAFNetWork GET:@"http://47.104.18.18/index.php/Mobile/Bridge/BrigeSlide" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        for (NSDictionary* dic in responseObject) {
            NSString* imaUrl=[NSString stringWithFormat:@"%@Public/img/img/%@",Main_ServerImage,dic[@"picnpath"]];
            [_loopIma addObject:imaUrl];
        }
        
        [self initCycleScrollView];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)initCycleScrollView
{
    SDCycleScrollView* cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 220) delegate:self placeholderImage:nil];
    cycleScrollView.imageURLStringsGroup=_loopIma;
    cycleScrollView.autoScrollTimeInterval=2.0;
    cycleScrollView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    [self.view addSubview:cycleScrollView];
    self.SDCScrollView=cycleScrollView;
    
}

- (void)loadCityData
{
    [XAFNetWork GET:@"http://47.104.18.18/index.php/Mobile/Bridge/Brigetext/" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {

       
        for (NSDictionary* dic in responseObject) {
            
            
            ActivityPageModel* model=[ActivityPageModel modelWithDict:dic];

            [_cityArr addObject:model];
        }
        
       [self updateCityUI:_cityArr];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {

    }];
}

- (void)updateCityUI:(NSMutableArray*)arr
{
    CGFloat x=50;
    CGFloat w=(kSCREEN_WIDTH-x*5)/4;
    UIView* backVie=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.SDCScrollView.frame), kSCREEN_WIDTH, w+25+20)];
    backVie.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:backVie];
  
    UIView* whiteView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, kSCREEN_WIDTH, 25+w)];
    whiteView.backgroundColor=[UIColor whiteColor];
    [backVie addSubview:whiteView];
    
    for (int i=0; i<4; i++) {
        ActivityPageModel* model=arr[i];
        UIButton* btn=[[UIButton alloc]init];
        int value= [model.idq intValue];
        btn.tag=10+value;
        [btn addTarget:self action:@selector(cityBtn:) forControlEvents:UIControlEventTouchUpInside];

        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,model.citypic]] forState:UIControlStateNormal];
        //self.SDCScrollView.frame获取不到frame
        
        btn.frame=CGRectMake(x+i*(w+x), 10,w, w);

        [whiteView addSubview:btn];

        UILabel* lab=[[UILabel alloc]init];
        //UILabel* lab=[[UILabel alloc]initWithFrame:CGRectMake(x+i*(w+x), CGRectGetMaxY(btn.frame), 0, 0)];
//        lab.backgroundColor=[UIColor yellowColor];
        lab.text=model.word;
        lab.textAlignment=NSTextAlignmentCenter;
        [lab setFont:[UIFont systemFontOfSize:10]];
        [lab sizeToFit];
        lab.frame=CGRectMake(x+i*(w+x), CGRectGetMaxY(btn.frame), w, 10);
        [whiteView addSubview:lab];
    }
}

- (void)cityBtn:(UIButton*)btn
{
   ActivityDetailController* dVC=[[ActivityDetailController alloc]init];
    NSString * idq=[NSString stringWithFormat:@"%ld",btn.tag-10];
    dVC.idq=idq;
    [self.navigationController pushViewController:dVC animated:YES];
    
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
