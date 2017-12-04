//
//  MyHeaderVeiw.h
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyHeaderVeiwDelegate <NSObject>

-(void)clickButton:(UIButton *)button;

@end
@interface MyHeaderVeiw : UIView
@property (nonatomic,weak) id<MyHeaderVeiwDelegate>delegate;

-(void)reloadData;
-(void)standInsideLetter:(NSInteger)number;


@end
