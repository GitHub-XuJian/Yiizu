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
{
    int _number;
}
@property (nonatomic, strong) MCPieChartView *pieChartView;
@property (nonatomic, strong) NSString *pieChartStr;
@property (nonatomic, strong) NSMutableArray *pieChartArray;
@end
@implementation PieChartView
- (NSMutableArray *)pieChartArray
{
    if (!_pieChartArray) {
        _pieChartArray = [NSMutableArray array];
    }
    return _pieChartArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIViwe];
    }
    return self;
}
- (void)reloadWithDict:(NSDictionary *)dict;
{
    _pieChartStr = [NSString stringWithFormat:@"未提现：%@\n已提现：%@",dict[@"num"],dict[@"ennum"]];
    _pieChartView.subTitleStr = [NSString stringWithFormat:@"平均持有：%@张",dict[@"codenumstate"]];
    _pieChartView.subTitleStr2 = [NSString stringWithFormat:@"平均等待：%@天",dict[@"personnumstate"]];
    _number = [dict[@"ennum"] intValue] + [dict[@"num"] intValue];
    [self.pieChartArray addObject:[NSNumber numberWithInt:[dict[@"ennum"] intValue]]];
    [_pieChartView reloadData];
}
- (void)createUIViwe
{
    _pieChartView = [[MCPieChartView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _pieChartView.dataSource = self;
    _pieChartView.delegate = self;
    //    _pieChartView.circle = NO;
    _pieChartView.pieBackgroundColor = [UIColor colorWithRed:0.40f green:0.60f blue:0.77f alpha:1.00f];
    //    _pieChartView.ringTitle = @"我拥有\n15张";
    _pieChartView.ringWidth = 20;
    _pieChartView.titleStr = @"队列总量";
    
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
    return [NSNumber numberWithInt:_number];
}
/**
 * 圆中心文字
 */
- (NSAttributedString *)ringTitleInPieChartView:(MCPieChartView *)pieChartView {
    return [[NSAttributedString alloc] initWithString:self.pieChartStr?self.pieChartStr:@"" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13], NSForegroundColorAttributeName: [UIColor blackColor]}];
}

- (UIColor *)pieChartView:(MCPieChartView *)pieChartView colorOfPieAtIndex:(NSInteger)index {
    if (index == 0) {
        return [UIColor colorWithRed:0.65f green:0.73f blue:0.36f alpha:1.00f];;
    }
    return [UIColor colorWithRed:0/255.0 green:207/255.0 blue:187/255.0 alpha:1.0];
}


@end
