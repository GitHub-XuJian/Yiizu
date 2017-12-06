//
//  ActivationCodeInputViewController.h
//  yizu
//
//  Created by 徐健 on 17/10/24.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ActivationCodeInputViewControllerBlock)();

@interface ActivationCodeInputViewController : UIViewController

@property (nonatomic, strong) ActivationCodeInputViewControllerBlock block;
@end
