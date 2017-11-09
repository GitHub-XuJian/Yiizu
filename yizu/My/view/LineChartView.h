//
//  LineChartView.h
//  yizu
//
//  Created by 徐健 on 2017/11/7.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineChartView : UIView

@property (nonatomic, strong) NSDictionary *recentlyDict;
@property (nonatomic, strong) NSDictionary *farthestDict;

- (void)reloadWith:(NSDictionary *)recentlyDict and:(NSDictionary *)farthestDict;

@end
