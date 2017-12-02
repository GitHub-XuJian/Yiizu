//
//  SlotMachines.h
//  yizu
//
//  Created by 徐健 on 2017/11/29.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SlotMachinesDelegate <NSObject>

-(void)determineBtnClick;

@end
@interface SlotMachines : UIView
@property (nonatomic,weak) id<SlotMachinesDelegate>delegate;

@property (nonatomic, strong) NSDictionary *dict;

@end
