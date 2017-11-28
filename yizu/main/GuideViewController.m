//
//  GuideViewController.m
//  yizu
//
//  Created by myMac on 2017/11/28.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "GuideViewController.h"
#import "SFRootVC.h"
#import "HomeViewController.h"
#import "LBTabBarController.h"

@interface GuideViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,copy) NSArray<UIImageView *> *imageViews;

@property (nonatomic,weak) UIButton *openBtn;

@end

static NSInteger const MaxItemCount = 4;

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addItemWithMaxItemCount];
    // Do any additional setup after loading the view.
}


- (void)addItemWithMaxItemCount {
    
    
    
    NSMutableArray *imageViews = [[NSMutableArray alloc] initWithCapacity:MaxItemCount];
    
    for (int index = 1; index <= MaxItemCount; index++) {
        
        NSString *imageName = [NSString stringWithFormat:@"%d",index];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.scrollView addSubview:imageView];
        
        imageView.image = [UIImage imageNamed:imageName];
        
        [imageViews addObject:imageView];
        
    }
    
    
    self.imageViews = imageViews;
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    __block CGFloat x = 0.0f;
    CGFloat Width  = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    CGFloat maxX = self.imageViews.count * Width;
    
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(maxX, 0);
    
    [self.imageViews enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        x = Width * idx;
        [obj setFrame:CGRectMake(x, 0, Width, height)];
    }];
    
    CGFloat btnWidth = Width * 0.6;
    CGFloat btnHeight = 60;
    CGFloat btnY = height - btnHeight * 3-20;
   
    CGFloat btnX = maxX - Width + (Width - btnWidth) * 0.5;
    
    self.openBtn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
    
    
}

- (void)open {
   
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    appDelegate.window.rootViewController =[[LBTabBarController alloc]init];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        
        self.scrollView = [[UIScrollView alloc] init];
        
        [self.view addSubview:_scrollView];
        
        self.scrollView.pagingEnabled = YES;
        self.scrollView.alwaysBounceVertical = NO;
        
    }
    return _scrollView;
}

- (UIButton *)openBtn {
    if (!_openBtn) {
        UIButton *open = [UIButton buttonWithType:UIButtonTypeCustom];
        //open.backgroundColor=[UIColor cyanColor];
        [self.scrollView addSubview:open];
        open.backgroundColor = [UIColor clearColor];
        [open addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
        _openBtn = open;
    }
    return _openBtn;
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
