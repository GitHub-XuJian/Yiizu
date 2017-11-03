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

@interface HomeCityBtnController ()
@property (nonatomic, strong) NSArray* cityArr;
@end


@implementation HomeCityBtnController


- (void)setCityArr:(NSArray *)cityArr
{
    _cityArr=cityArr;
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"选择城市";
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
   
    [self.collectionView registerClass:[CityListCell class] forCellWithReuseIdentifier:@"citycell"];
    #define DGBColorA(r,g,b,a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
    self.collectionView.backgroundColor = DGBColorA(245, 245, 245, 1);
    //垂直方向反弹是否有效要开启弹簧效果
    self.collectionView.alwaysBounceVertical = YES;
    
    [CityListModel CityListWithUrl:[NSString stringWithFormat:@"%@Mobile/Index/index_city",Main_Server] success:^(NSArray *array) {
        self.cityArr=array;
       
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
#define  screenW [UIScreen mainScreen].bounds.size.width
    CGFloat itemW = screenW / 3 - 10;
    CGFloat itemH = 50;
    collectionFL.minimumLineSpacing = 5;
    collectionFL.minimumInteritemSpacing = 5;
    collectionFL.itemSize = CGSizeMake(itemW, itemH);
    collectionFL.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
    collectionFL.headerReferenceSize = CGSizeMake(screenW, 60);
    
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.cityArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CityListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"citycell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    
    CityListModel* model=self.cityArr[indexPath.item];
    
    cell.cityName=model.name;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CityListModel* model=self.cityArr[indexPath.item];
    NSString* url=[NSString stringWithFormat:@"%@Mobile/Index/index_Chamber/data/%@/page/1",Main_Server,model.cityId];
    NSLog(@"点击行按钮=%@%@",model.name,url);
    if ([self.delegate respondsToSelector:@selector(HomeCityBtnTitle:url:)]) {
        [self.delegate HomeCityBtnTitle:model.name url:model.cityId];
    }
  
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
