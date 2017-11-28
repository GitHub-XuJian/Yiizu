//
//  WalletView.h
//  yizu
//
//  Created by 徐健 on 2017/11/17.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WalletViewDelegate <NSObject>

-(void)clickWithTag:(NSInteger)viewTag;

@end
@interface WalletView : UIView
@property (nonatomic,weak) id<WalletViewDelegate>delegate;

- (void)reloadMonay:(NSString *)monayStr;
@end
