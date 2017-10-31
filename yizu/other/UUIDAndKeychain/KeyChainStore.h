//
//  KeyChainStore.h
//  RMD
//
//  Created by 顾立伟 on 2016/11/28.
//  Copyright © 2016年 RMD－MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject
/**存数据*/
+ (void)save:(NSString *)service data:(id)data;
/**取数据*/
+ (id)load:(NSString *)service;
/**删除数据*/
+ (void)deleteKeyData:(NSString *)service;
@end
