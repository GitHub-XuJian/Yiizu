//
//  LoopImageModel.m
//  yizu
//
//  Created by myMac on 2017/10/24.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "LoopImageModel.h"

@implementation LoopImageModel

- (instancetype)ModelWithDict:(NSDictionary *)dic
{
    
    LoopImageModel* model=[LoopImageModel new];
    
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
