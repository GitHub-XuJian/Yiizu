//
//  CityListModel.h
//  yizu
//
//  Created by myMac on 2017/10/26.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityListModel : NSObject

@property (nonatomic,strong) NSString* cityId;
@property (nonatomic,strong) NSString* name;

//更改城市id访问区域id接口
@property (nonatomic,copy,readonly) NSString  *urlString;

+ (instancetype)ModelWithDict:(NSDictionary*)dic;

+(void)CityListWithUrl:(NSString*)url success:(void(^)(NSArray* array))sBlock error:(void(^)())eBlock;
@end
