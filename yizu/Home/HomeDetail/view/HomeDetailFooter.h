//
//  HomeDetailFooter.h
//  yizu
//
//  Created by myMac on 2017/11/14.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeDetailFooter : UIView

//
@property (nonatomic, copy) NSString* time;
//
@property (nonatomic, copy) NSString* full;
//
@property (nonatomic, copy) NSString* phone;

+ (instancetype)makeCustomFooterView;


@end
