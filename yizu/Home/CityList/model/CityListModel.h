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
@property (nonatomic,strong) NSArray* list;

//表示列表分组是否可见（开启，合上）
@property(nonatomic,assign,getter=isVisible)BOOL visible;



//更改城市id访问区域id接口
@property (nonatomic,copy,readonly) NSString  *urlString;

+ (instancetype)ModelWithDict:(NSDictionary*)dic;

+(void)CityListWithUrl:(NSString*)url success:(void(^)(NSArray* array))sBlock error:(void(^)())eBlock;
@end
