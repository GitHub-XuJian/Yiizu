//
//  XSaverTool.m
//  yizu
//
//  Created by 徐健 on 17/10/27.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "XSaverTool.h"

@implementation XSaverTool
+ (nullable id)objectForKey:(NSString *)defaultName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)setObject:(nullable id)value forKey:(NSString *)defaultName{
    
    if (defaultName) {
        // 屏蔽一下外界来回滑动的行为
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (BOOL)boolForKey:( NSString * _Nullable )defaultName
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:defaultName];
}
+ (void)setBool:(BOOL)value forKey:(NSString * _Nullable )defaultName
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:defaultName];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)removeDataForKey:(NSString * _Nullable)defaultName
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)removeAllDatas
{
    NSString *bundle = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:bundle];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
