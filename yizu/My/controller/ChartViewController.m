//
//  ChartViewController.m
//  yizu
//
//  Created by 徐健 on 17/10/25.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ChartViewController.h"
#import "RankingView.h"
#import "PieChartView.h"
#import "LineChartView.h"
#import "HXLineChart.h"

@interface ChartViewController ()
/**
 * 排名数据
 */
@property (nonatomic, strong) RankingView *rankingView;
/**
 * 饼图数据
 */
@property (nonatomic, strong) NSMutableArray *pieChartArray;
@property (nonatomic, strong) NSString *pieChartStr;
@property (nonatomic, strong) PieChartView *pieView;
/**
 * 横线图数据
 */
@property (nonatomic, strong) LineChartView *lineView;
/**
 * 折现图数据
 */
@property (nonatomic, strong) NSMutableArray *brokenLineArray;
@property (nonatomic, strong) HXLineChart *brokenLine;
@end

@implementation ChartViewController
- (NSMutableArray *)brokenLineArray
{
    if (!_brokenLineArray) {
        _brokenLineArray = [NSMutableArray array];
    }
    return _brokenLineArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    [self createData];
    [self createViewUI];
}
- (void)createData
{
    
    NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey]};
    NSString *rankingUrlStr = [NSString stringWithFormat:@"%@Mobile/Queue/codeApi",Main_Server];
    [XAFNetWork GET:rankingUrlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        /**
         * 排名
         */
        if (responseObject) {
            [self.rankingView reloadRanking:responseObject[@"keepSort"]];
            /**
             * 饼图
             */
            [self.pieView reloadWithDict:responseObject];
            /**
             * 横线图
             */
            [self.lineView reloadWith:responseObject[@"Recently"] and:responseObject[@"Farthest"]];
            /**
             * 折现图
             */
            [self.brokenLine setValue:[self brokenLineArrayWithDict:responseObject] withYLineCount:6];
            self.brokenLine.lineColor = [UIColor redColor];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)createViewUI
{
    // 1.创建UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds; // frame中的size指UIScrollView的可视范围
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    CGFloat scrollViewContactSize = 0;
    /**
     * 排名
     */
    self.rankingView = [[RankingView alloc] initWithFrame:XCGRectMake(10,1, kSCREEN_WIDTH-20, 200)];
    [scrollView addSubview:self.rankingView];
    scrollViewContactSize += self.rankingView.y+self.rankingView.height;
    /**
     * 圆饼图
     */
    self.pieView = [[PieChartView alloc] initWithFrame:CGRectMake(self.rankingView.x, self.rankingView.y+self.rankingView.height+5, (kSCREEN_WIDTH-20)/2-5, 210)];
    [scrollView addSubview:self.pieView];
    /**
     * 线线图
     */
    self.lineView = [[LineChartView alloc] initWithFrame:CGRectMake(self.pieView.x+self.pieView.width+5, self.pieView.y, (kSCREEN_WIDTH-20)/2-5, 210)];
    [scrollView addSubview:self.lineView];
    scrollViewContactSize += self.lineView.height;

    /**
     * 折线图
     */
    self.brokenLine = [[HXLineChart alloc] initWithFrame:CGRectMake(10, self.lineView.y+self.lineView.height+5, kSCREEN_WIDTH-20, kSCREEN_HEIGHT-64-self.rankingView.height-self.pieView.height-20)];
    [self.brokenLine setTitleArray:@[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"]];
    self.brokenLine.lineColor = [UIColor redColor];
    self.brokenLine.fillColor = [self colorWithHexString:@"#2e3f53" alpha:0.5];
    self.brokenLine.backgroundLineColor = [self colorWithHexString:@"#4b4e52" alpha:1];
    //边框宽度
    [_brokenLine.layer setBorderWidth:0.5];
    _brokenLine.layer.borderColor=kColorLine.CGColor;
    [scrollView addSubview:self.brokenLine];
    scrollViewContactSize += self.brokenLine.height;

    // 设置UIScrollView的滚动范围（内容大小）
    scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, scrollViewContactSize);
    // 隐藏水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    // 用来记录scrollview滚动的位置
    //    scrollView.contentOffset = ;
    
    // 去掉弹簧效果
    //    scrollView.bounces = NO;
    
    
}
#pragma mark 设置16进制颜色
- (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}
- (NSMutableArray *)brokenLineArrayWithDict:(NSDictionary *)dict
{
    NSMutableArray *brokenLineArray = [NSMutableArray array];
    NSDictionary *codeWeekDict = dict[@"codeWeek"];
    NSNumber *monNum =[NSNumber numberWithInt:[codeWeekDict[@"monNum"] intValue]];
    [brokenLineArray addObject:monNum];
    NSNumber *tueNum =[NSNumber numberWithInt:[codeWeekDict[@"tueNum"] intValue]];
    [brokenLineArray addObject:tueNum];
    NSNumber *wedNum =[NSNumber numberWithInt:[codeWeekDict[@"wedNum"] intValue]];
    [brokenLineArray addObject:wedNum];
    NSNumber *thuNum =[NSNumber numberWithInt:[codeWeekDict[@"thuNum"] intValue]];
    [brokenLineArray addObject:thuNum];
    NSNumber *friNum =[NSNumber numberWithInt:[codeWeekDict[@"friNum"] intValue]];
    [brokenLineArray addObject:friNum];
    NSNumber *satNum =[NSNumber numberWithInt:[codeWeekDict[@"satNum"] intValue]];
    [brokenLineArray addObject:satNum];
    NSNumber *sunNum =[NSNumber numberWithInt:[codeWeekDict[@"sunNum"] intValue]];
    [brokenLineArray addObject:sunNum];
    return brokenLineArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
