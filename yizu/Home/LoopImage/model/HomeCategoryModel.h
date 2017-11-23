//
//  HomeCategoryModel.h
//  yizu
//
//  Created by myMac on 2017/11/21.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCategoryModel : NSObject

@property (nonatomic, copy) NSString* icon;
@property (nonatomic, copy) NSString* insid;
@property (nonatomic, copy) NSString* tradename;

+(instancetype)modelWithDict:(NSDictionary*)dic;


@end
