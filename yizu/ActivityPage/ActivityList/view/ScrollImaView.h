//
//  ScrollImaView.h
//  yizu
//
//  Created by myMac on 2017/11/27.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol myViewidDelegate <NSObject>

-(void)ImaViewActid:(NSString*)actid;

@end


@interface ScrollImaView : UIImageView

@property (nonatomic, copy) NSString* activityid;

@property (nonatomic, strong) id<myViewidDelegate> delegate;
@end
