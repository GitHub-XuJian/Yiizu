//
//  HomeCityBtnController.m
//  yizu
//
//  Created by myMac on 2017/10/26.
//  Copyright © 2017年 XuJian. All rights reserved.
//
#import "HomeCityBtnController.h"
#import "CityListModel.h"
#import "CityListCell.h"
#import "SmallCityListModel.h"
#import "HeadCityBtnReusableView.h"
#import "SmallCityListModel.h"


//点击城市按钮请求的是城市（排序方式）离我最近
static NSString * const cityUrl = @"%@Mobile/Index/index_Chamber/data/%@personid/3/sequence/0/page/1/";

@interface HomeCityBtnController ()<HeadCityBtnViewDelegate>
@property (nonatomic, strong) NSArray* cityArr;
@end


@implementation HomeCityBtnController


//- (void)setCityArr:(NSArray *)cityArr
//{
//    _cityArr=cityArr;
//    [self.collectionView reloadData];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"请选择城市";
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self.collectionView registerClass:[HeadCityBtnReusableView class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"headV"];
    [self.collectionView registerClass:[CityListCell class] forCellWithReuseIdentifier:@"citycell"];
    //self.collectionView.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //垂直方向反弹是否有效要开启弹簧效果
    self.collectionView.alwaysBounceVertical = YES;
    
    
    
 
    
    
    
    [CityListModel CityListWithUrl:[NSString stringWithFormat:@"%@Mobile/Index/index_city",Main_Server] success:^(NSArray *array) {
        
        self.cityArr=array;
        [self.collectionView reloadData];
       
    } error:^{
        NSLog(@"出错了");
        [SVProgressHUD dismiss];

        [SVProgressHUD showErrorWithStatus:@"出错了"];

    }];
    
    // Do any additional setup after loading the view.
}
- (void)cancle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (instancetype)init {
    
    UICollectionViewFlowLayout *collectionFL = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = (kSCREEN_WIDTH - 50)/3;
    CGFloat itemH = 40;
    collectionFL.minimumLineSpacing = 10;//横向
    collectionFL.minimumInteritemSpacing = 10;
    collectionFL.itemSize = CGSizeMake(itemW, itemH);
    collectionFL.sectionInset=UIEdgeInsetsMake(5, 10, 5, 10);
    collectionFL.headerReferenceSize = CGSizeMake(kSCREEN_WIDTH, 45);
    
    return [super initWithCollectionViewLayout:collectionFL];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.cityArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    CityListModel* model=self.cityArr[section];
   
    //展开合上的原理就是合上的时候显示（返回）0行
    if (model.visible) {
        return model.list.count;
    }else
    {
        return 0;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CityListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"citycell" forIndexPath:indexPath];
    cell.layer.cornerRadius=15;
    cell.contentView.layer.cornerRadius=15.0f;
    //cell.contentView.layer.borderWidth=0.3f;
    cell.contentView.layer.masksToBounds=YES;
    cell.backgroundColor=[UIColor whiteColor];
    
  //加阴影
//    cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//    cell.layer.shadowOffset = CGSizeMake(-10,-10);
//    cell.layer.shadowRadius = 2.0f;
//    cell.layer.shadowOpacity = 0.4f;
//    cell.layer.masksToBounds = NO;
//    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    
    CityListModel* model=self.cityArr[indexPath.section];
    SmallCityListModel* smodel=model.list[indexPath.item];
    
    cell.cityName=smodel.name;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    CityListModel* model=self.cityArr[indexPath.section];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        HeadCityBtnReusableView *headV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headV" forIndexPath:indexPath];
        
//        if (indexPath.section == 0) {
//
//            model.visible=YES;
//
//        }
        headV.tag=indexPath.section;
        
        headV.delegate=self;
        
        headV.titleName=model.name;
        headV.model=model;
        return headV;
        
    }else {
        
        return nil;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CityListModel* model=self.cityArr[indexPath.section];
    SmallCityListModel* smodel=model.list[indexPath.item];
    
    
    // 点击城市按钮请求的是城市（排序方式）离我最近
    //@"%@Mobile/Index/index_Chamber/data/%@personid/3/sequence/0/page/1/"
    NSString* url=[NSString stringWithFormat:@"%@Mobile/Index/index_Chamber/data/%@/personid/3/sequence/0/page/1/",Main_Server,smodel.cityId];
    
    NSLog(@"点击行按钮=%@%@",model.name,url);

    //代理回传城市title。。。
    if ([self.delegate respondsToSelector:@selector(HomeCityBtnTitle:url:cityId:)]) {
        [self.delegate HomeCityBtnTitle:smodel.name url:url cityId:smodel.cityId];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)HeadClickBtn:(HeadCityBtnReusableView *)HeaderView
{
    //局部刷新
    NSIndexSet* indeSet=[NSIndexSet indexSetWithIndex:HeaderView.tag];
    //局部刷新一组表格
    [self.collectionView reloadSections:indeSet];
}


@end
