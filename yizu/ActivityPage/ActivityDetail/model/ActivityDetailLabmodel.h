//
//  ActivityDetailLabmodel.h
//  yizu
//
//  Created by myMac on 2017/11/14.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityDetailLabmodel : NSObject


@property (nonatomic, copy) NSString* literal;

@property (nonatomic, copy) NSString* title;

+ (instancetype)modelWithDict:(NSDictionary*)dic;

@end
