//
//  UUID.m
//  RMD
//
//  Created by 顾立伟 on 2016/11/28.
//  Copyright © 2016年 RMD－MAC. All rights reserved.
//

#import "UUID.h"
#import "KeyChainStore.h"

@implementation UUID
+(NSString *)getUUID
{
    NSString * strUUID = (NSString *)[KeyChainStore load:@"registrationDebarkation.UUID"];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [KeyChainStore save:@"registrationDebarkation.UUID" data:strUUID];
        
    }
    return strUUID;
}
@end
