//
//  PopMenuView.h
//  yizu
//
//  Created by myMac on 2017/11/22.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopMenuView;

@protocol PopmenuViewDelegate <NSObject>

-(void)popViewClickBtn:(PopMenuView*)popView;

@end


@interface PopMenuView : UIView

@property (nonatomic, assign) id<PopmenuViewDelegate>delegate;

@property (nonatomic, copy) void (^hideHandle)();

/**
 *  实例化方法
 *
 *  @param array  items，包含字典，字典里面包含标题（title）、图片名（imageName）
 *  @param width  宽度
 *  @param point  三角的顶角坐标（基于window）
 *  @param action 点击回调
 */
- (instancetype)initWithItems:(NSArray <NSDictionary *>*)array
                        width:(CGFloat)width
             triangleLocation:(CGPoint)point
                       action:(void(^)(NSInteger index))action;

/**
 *  类方法展示
 *
 *  @param array  items，包含字典，字典里面包含标题（title）、图片名（imageName）
 *  @param width  宽度
 *  @param point  三角的顶角坐标（基于window）
 *  @param action 点击回调
 */
+ (void)showWithItems:(NSArray <NSDictionary *>*)array
                width:(CGFloat)width
     triangleLocation:(CGPoint)point
               action:(void(^)(NSInteger index))action;

- (void)show;
- (void)hide;


@end
