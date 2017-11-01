//
//  SFNavView.h
//  ContactsManager
//
//  Created by 徐健 on 17/1/10.
//  Copyright © 2017年 邵峰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LeftBtnBlock)(void);
typedef void (^RightBtnBlock)(void);

@interface SFNavView : UIView

- (instancetype)initWithFrame:(CGRect)frame                 // 导航栏的frame
             andTitle:(NSString *)titleStr          // 中间标题
      andLeftBtnTitle:(NSString *)leftBtnStr        // 左侧按钮文字，没有则无按钮
     andRightBtnTitle:(NSString *)rightBtnStr       // 同上右侧
      andLeftBtnBlock:(LeftBtnBlock)leftBlock       // 左侧按钮回调
     andRightBtnBlock:(RightBtnBlock)rightBlock;    // 右侧按钮回调

@end
