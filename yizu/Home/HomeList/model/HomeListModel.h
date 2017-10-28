//
//  HomeListModel.h
//  yizu
//
//  Created by myMac on 2017/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeListModel : NSObject

//商户名称
@property (nonatomic, copy) NSString* chambername;
//已售
@property (nonatomic, copy) NSString* obtained;
//点赞数
@property (nonatomic, copy) NSString* upvote;
//商户简介
@property (nonatomic, copy) NSString* chamberjj;

@property (nonatomic, copy) NSString* image1;
@property (nonatomic, copy) NSString* image2;
@property (nonatomic, copy) NSString* image3;
@property (nonatomic, copy) NSString* icon;

+ (instancetype)ModelWithDict:(NSDictionary*)dic;

+(void)HomeListWithUrl:(NSString*)url success:(void(^)(NSArray* array))sBlock error:(void(^)())eBlock;



@end
