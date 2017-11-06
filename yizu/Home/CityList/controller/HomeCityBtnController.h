//
//  HomeCityBtnController.h
//  yizu
//
//  Created by myMac on 2017/10/26.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeCityBtnDelegate <NSObject>

-(void)HomeCityBtnTitle:(NSString*)title url:(NSString*)url cityId:(NSString*)cid;

@end

@interface HomeCityBtnController : UICollectionViewController

@property(nonatomic, strong)id<HomeCityBtnDelegate>delegate;

@end
