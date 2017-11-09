//
//  AboutusView.h
//  yizu
//
//  Created by 徐健 on 2017/11/7.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AboutusViewDelegate <NSObject>

-(void)clickButton:(id)recognizer;

@end
@interface AboutusView : UIView
@property (nonatomic,weak) id<AboutusViewDelegate>delegate;

@end
