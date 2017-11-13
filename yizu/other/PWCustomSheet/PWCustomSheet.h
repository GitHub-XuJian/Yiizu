//
//  PWCustomSheet.h
//  自定义Sheet
//
//  Created by Oriental on 17/1/16.
//  Copyright © 2017年 Oriental Horizon. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PWCustomSheetDelegate <NSObject>

-(void)clickButton:(UIButton *)button;

@end

@interface PWCustomSheet : UIView

@property (nonatomic,weak) id<PWCustomSheetDelegate>delegate;

-(PWCustomSheet*)initWithButtons:(NSArray*)allButtons;

@end
