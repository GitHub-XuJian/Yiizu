//
//  HomeListModel.m
//  yizu
//
//  Created by myMac on 2017/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeListModel.h"

@implementation HomeListModel

- (instancetype)ModelWithDict:(NSDictionary *)dic
{
 
    HomeListModel* model=[HomeListModel new];
    
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
