//
//  SmallCityListModel.h
//  yizu
//
//  Created by myMac on 2017/11/18.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmallCityListModel : NSObject

@property (nonatomic,strong) NSString* cityId;
@property (nonatomic,strong) NSString* name;

+ (instancetype)ModelWithDict:(NSDictionary*)dic;

@end
