//
//  LoopImageController.m
//  yizu
//
//  Created by myMac on 2017/10/24.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "LoopImageController.h"
#import "LoopImageCell.h"
@interface LoopImageController ()
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation LoopImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCollectionViewStyle];
 
}

-(void)setCollectionViewStyle
{
    self.flowLayout.minimumInteritemSpacing=0;
    self.flowLayout.minimumLineSpacing=0;
    self.flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    self.collectionView.backgroundColor=[UIColor cyanColor];
    self.collectionView.pagingEnabled=YES;
    self.collectionView.showsHorizontalScrollIndicator=NO;
    self.collectionView.bounces=NO;
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.flowLayout.itemSize=self.collectionView.bounds.size;
    
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
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LoopImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"loopcell" forIndexPath:indexPath];
    
   
    
    return cell;
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
