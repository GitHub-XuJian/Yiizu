//
//  HomeListModel.m
//  yizu
//
//  Created by myMac on 2017/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeListModel.h"


@implementation HomeListModel

+(instancetype)ModelWithDict:(NSDictionary *)dic
{
 
    HomeListModel* model=[HomeListModel new];
    
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

+(void)HomeListWithUrl:(NSString *)url success:(void (^)(NSArray *))sBlock error:(void (^)())eBlock
{
  
    [XAFNetWork GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray* mArr=[NSMutableArray array];
        NSArray* listArr=responseObject[@"list"];
        NSLog(@"homeList==%@",listArr);
        for (NSDictionary* dic in listArr) {
            HomeListModel* model=[self ModelWithDict:dic];
            [mArr addObject:model];
        }
        if (sBlock) {
            sBlock(mArr.copy);
              //[SVProgressHUD setMinimumDismissTimeInterval:0.25];
              //[SVProgressHUD showSuccessWithStatus:@"加载完成"];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}



@end
