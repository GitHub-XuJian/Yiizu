//
//  HomeDetailImaView.h
//  yizu
//
//  Created by 李大霖 on 2017/12/4.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeDetailImaView;

@protocol myHomeDetailImaDelegate <NSObject>

-(void)ImaViewima:(HomeDetailImaView*)imaView;

@end

@interface HomeDetailImaView : UIImageView

@property (nonatomic, strong) id<myHomeDetailImaDelegate>delegate;

@end
