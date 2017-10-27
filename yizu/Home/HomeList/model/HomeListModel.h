//
//  HomeListModel.h
//  yizu
//
//  Created by myMac on 2017/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeListModel : NSObject

//shang hu name
@property (nonatomic, copy) NSString* chambername;
//yi shou
@property (nonatomic, copy) NSString*   obtained;

@property (nonatomic, copy) NSString* image1;
@property (nonatomic, copy) NSString* image2;
@property (nonatomic, copy) NSString* image3;

+ (instancetype)ModelWithDict:(NSDictionary*)dic;

+(void)HomeListWithUrl:(NSString*)url success:(void(^)(NSArray* array))sBlock error:(void(^)())eBlock;



@end
