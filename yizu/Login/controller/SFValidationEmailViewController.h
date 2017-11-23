//
//  SFValidationEmailViewController.h
//  ContactsManager
//
//  Created by 徐健 on 17/7/14.
//  Copyright © 2017年 邵峰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LoginValidationBlock)(NSDictionary *dict);

@interface SFValidationEmailViewController : UIViewController

@property (nonatomic, strong) NSString *emailStr;
@property (nonatomic, assign) BOOL isValidation;
@property (nonatomic, strong) NSString *validationStr;
@property (nonatomic, assign) BOOL isBindingPhone;

@property (nonatomic, strong) LoginValidationBlock validationBlock;

@end
