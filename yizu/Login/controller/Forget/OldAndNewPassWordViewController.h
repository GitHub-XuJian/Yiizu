//
//  OldAndNewPassWordViewController.h
//  yizu
//
//  Created by 徐健 on 2017/10/31.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^OldAndNewPassWordViewControllerBlock)();

@interface OldAndNewPassWordViewController : UIViewController

@property (nonatomic, strong) OldAndNewPassWordViewControllerBlock block;
@property (nonatomic, strong) NSString *phoneStr;
@end
