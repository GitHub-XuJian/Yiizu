//
//  ActivityPageModel.h
//  yizu
//
//  Created by myMac on 2017/11/8.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityPageModel : NSObject

@property (nonatomic, copy) NSString* word;

@property (nonatomic, copy) NSString* citypic;

@property (nonatomic, copy) NSString* idq;

@property (nonatomic, copy) NSString* town;

+ (instancetype)modelWithDict:(NSDictionary*)dic;

@end
