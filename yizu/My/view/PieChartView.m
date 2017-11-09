//
//  PieChartView.m
//  yizu
//
//  Created by 徐健 on 2017/11/7.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "PieChartView.h"
#import "MCPieChartView.h"

@interface PieChartView ()<MCPieChartViewDataSource, MCPieChartViewDelegate>
@property (nonatomic, strong) MCPieChartView *pieChartView;

@end
@implementation PieChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIViwe];
    }
    return self;
}
- (void)createUIViwe
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 1; i ++) {
        [mutableArray addObject:@50];
    }
    _pieChartArray = [NSMutableArray arrayWithArray:mutableArray];
    
    _pieChartView = [[MCPieChartView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _pieChartView.dataSource = self;
    _pieChartView.delegate = self;
    //    _pieChartView.circle = NO;
    _pieChartView.pieBackgroundColor = [UIColor colorWithRed:0.40f green:0.60f blue:0.77f alpha:1.00f];
    //    _pieChartView.ringTitle = @"我拥有\n15张";
    _pieChartView.ringWidth = 20;
    _pieChartView.titleStr = @"队列总量";
    _pieChartView.subTitleStr = @"队列总量";
    _pieChartView.subTitleStr2 = @"队列总量";
    
    //边框宽度
    [_pieChartView.layer setBorderWidth:0.5];
    _pieChartView.layer.borderColor=kColorLine.CGColor;
    [self addSubview:_pieChartView];
    
    [_pieChartView reloadDataWithAnimate:YES];
}

#pragma mark - PieChartViewDelegate
- (NSInteger)numberOfPieInPieChartView:(MCPieChartView *)pieChartView {
    return _pieChartArray.count;
}

- (id)pieChartView:(MCPieChartView *)pieChartView valueOfPieAtIndex:(NSInteger)index {
    return _pieChartArray[index];
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
    return [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"我拥有\n%@张",self.pieChartStr] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13], NSForegroundColorAttributeName: [UIColor blackColor]}];
}

- (UIColor *)pieChartView:(MCPieChartView *)pieChartView colorOfPieAtIndex:(NSInteger)index {
    if (index == 0) {
        return [UIColor colorWithRed:0.65f green:0.73f blue:0.36f alpha:1.00f];;
    }
    return [UIColor colorWithRed:0/255.0 green:207/255.0 blue:187/255.0 alpha:1.0];
}


@end
