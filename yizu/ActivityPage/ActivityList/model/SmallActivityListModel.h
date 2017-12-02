//
//  SmallActivityListModel.h
//  yizu
//
//  Created by myMac on 2017/11/30.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmallActivityListModel : NSObject

@property (nonatomic, copy) NSString* activityid;

@property (nonatomic, copy) NSString* mainpic;

+(instancetype)modelWithDict:(NSDictionary*)dic;

@end
