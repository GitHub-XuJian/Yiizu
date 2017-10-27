//
//  XSaverTool.h
//  yizu
//
//  Created by 徐健 on 17/10/27.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSaverTool : NSObject
+ (void)setObject:(nullable id)value forKey:(NSString * _Nullable )defaultName;
+ (nullable id)objectForKey:( NSString * _Nullable )defaultName;
+ (void)setBool:(BOOL)value forKey:(NSString * _Nullable )defaultName;
+ (BOOL)boolForKey:( NSString * _Nullable )defaultName;
+ (void)removeDataForKey:(NSString * _Nullable)defaultName;
+ (void)removeAllDatas;

@end
