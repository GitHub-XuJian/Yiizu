//
//  ChartViewController.m
//  yizu
//
//  Created by 徐健 on 17/10/25.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ChartViewController.h"
#import "MCBarChartView.h"
#import "MCPieChartView.h"

@interface ChartViewController ()<MCBarChartViewDataSource, MCBarChartViewDelegate,MCPieChartViewDataSource, MCPieChartViewDelegate>
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSMutableArray *histogramDataSource;
@property (strong, nonatomic) MCBarChartView *barChartView;

@property (nonatomic, strong) NSArray *pieChartdataSource;
@property (nonatomic, strong) MCPieChartView *pieChartView;

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    [self createViewUI];
}
- (void)createViewUI
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(10, 65, kSCREEN_WIDTH-20, (kSCREEN_HEIGHT-65)/4);
    view.backgroundColor = [UIColor colorWithRed:0.70f green:0.13f blue:0.35f alpha:1.00f];
    //设置圆角
    view.layer.cornerRadius = 10;
    //将多余的部分切掉
    view.layer.masksToBounds = YES;
    [self.view addSubview:view];
    /**
     * 柱状图
     */
    _titles = @[@"1", @"7", @"14", @"21", @"28"];
    _histogramDataSource = [NSMutableArray arrayWithArray:@[@[@5, @3], @[@5, @6], @[@7, @2], @[@9, @3], @[@5, @3]]];
    
    _barChartView = [[MCBarChartView alloc] initWithFrame:CGRectMake(view.x, view.y+view.height+5, view.width, view.height)];
    _barChartView.tag = 222;
    _barChartView.dataSource = self;
    _barChartView.delegate = self;
    _barChartView.maxValue = @10;
    _barChartView.unitOfYAxis = @"K";
    _barChartView.numberOfYAxis = 4;
    _barChartView.titleStr = @"补贴券（按日期）回购计划";
    _barChartView.titleArray = @[@"今日市价",@"官方回购价"];
    _barChartView.colorOfXAxis = [UIColor blackColor];
    _barChartView.colorOfXText = [UIColor blackColor];
    _barChartView.colorOfYAxis = [UIColor blackColor];
    _barChartView.colorOfYText = [UIColor blackColor];
    //边框宽度
    [_barChartView.layer setBorderWidth:0.5];
    _barChartView.layer.borderColor=kColorLine.CGColor;
    [self.view addSubview:_barChartView];
    /**
     * 是否带动画
     */
    [_barChartView reloadDataWithAnimate:YES];
    
    /**
     * 圆饼图
     */
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 1; i ++) {
        [mutableArray addObject:@30];
    }
    _pieChartdataSource = [NSArray arrayWithArray:mutableArray];
    
    _pieChartView = [[MCPieChartView alloc] initWithFrame:CGRectMake(_barChartView.x, _barChartView.y+_barChartView.height+5, (kSCREEN_WIDTH-20)/2-5, view.height)];
    _pieChartView.dataSource = self;
    _pieChartView.delegate = self;
//    _pieChartView.circle = NO;
    _pieChartView.pieBackgroundColor = [UIColor colorWithRed:0.40f green:0.60f blue:0.77f alpha:1.00f];
    _pieChartView.ringTitle = @"我拥有\n15张";
    _pieChartView.ringWidth = 20;
    //边框宽度
    [_pieChartView.layer setBorderWidth:0.5];
    _pieChartView.layer.borderColor=kColorLine.CGColor;
    [self.view addSubview:_pieChartView];
    
    [_pieChartView reloadDataWithAnimate:YES];
}
#pragma mark - BarChartViewDelegate
/**
 * 有几列
 */
- (NSInteger)numberOfSectionsInBarChartView:(MCBarChartView *)barChartView {
    return [_histogramDataSource count];
    
}
/**
 * 每列几行
 */
- (NSInteger)barChartView:(MCBarChartView *)barChartView numberOfBarsInSection:(NSInteger)section {
    return [_histogramDataSource[section] count];
}
/**
 * 每行数据
 */
- (id)barChartView:(MCBarChartView *)barChartView valueOfBarInSection:(NSInteger)section index:(NSInteger)index {
    return _histogramDataSource[section][index];
}
/**
 * 柱子的颜色
 */
- (UIColor *)barChartView:(MCBarChartView *)barChartView colorOfBarInSection:(NSInteger)section index:(NSInteger)index {
    
    if (index == 0) {
        return [UIColor redColor];
    }
    return [UIColor blackColor];
}
/**
 * X轴标题
 */
- (NSString *)barChartView:(MCBarChartView *)barChartView titleOfBarInSection:(NSInteger)section {
        return _titles[section];
}
/**
 * 柱子的提示
 */
- (NSString *)barChartView:(MCBarChartView *)barChartView informationOfBarInSection:(NSInteger)section index:(NSInteger)index {
    
    return nil;
}
/**
 * 设置柱子宽度
 */
- (CGFloat)barWidthInBarChartView:(MCBarChartView *)barChartView {
    
        return 10;
}

- (CGFloat)paddingForSectionInBarChartView:(MCBarChartView *)barChartView {
        return 20;
}

#pragma mark - PieChartViewDelegate
- (NSInteger)numberOfPieInPieChartView:(MCPieChartView *)pieChartView {
    return _pieChartdataSource.count;
}

- (id)pieChartView:(MCPieChartView *)pieChartView valueOfPieAtIndex:(NSInteger)index {
    return _pieChartdataSource[index];
}
/**
 * 圆最大值
 */
- (id)sumValueInPieChartView:(MCPieChartView *)pieChartView {
    return @100;
}
/**
 * 圆中心文字
 */
- (NSAttributedString *)ringTitleInPieChartView:(MCPieChartView *)pieChartView {
    return [[NSAttributedString alloc] initWithString:@"我拥有\n15张" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13], NSForegroundColorAttributeName: [UIColor blackColor]}];
}

- (UIColor *)pieChartView:(MCPieChartView *)pieChartView colorOfPieAtIndex:(NSInteger)index {
    if (index == 0) {
        return [UIColor colorWithRed:0.65f green:0.73f blue:0.36f alpha:1.00f];;
    }
    return [UIColor colorWithRed:0/255.0 green:207/255.0 blue:187/255.0 alpha:1.0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
