//
//  CityListModel.m
//  yizu
//
//  Created by myMac on 2017/10/26.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "CityListModel.h"
#import "SmallCityListModel.h"

@implementation CityListModel


+(instancetype)ModelWithDict:(NSDictionary *)dic
{
    
    CityListModel* model=[self new];
    
    model.cityId=dic[@"id"];
    model.name=dic[@"name"];
    //[model setValuesForKeysWithDictionary:dic];
     NSMutableArray* arrModel=[NSMutableArray array];
    for (NSDictionary* small_dic in dic[@"list"]) {
        SmallCityListModel* sModel=[SmallCityListModel ModelWithDict:small_dic];
        [arrModel addObject:sModel];
    }
    model.list=arrModel;
    
    return model;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

//更改对应的的路径
- (NSString *)urlString {
    //Mobile/Index/index_district/data/城市id
    return [NSString stringWithFormat:@"%@Mobile/Index/index_district/data/%@",Main_Server,self.cityId];
}


+(void)CityListWithUrl:(NSString *)url success:(void (^)(NSArray *))sBlock error:(void (^)())eBlock
{
    [XAFNetWork GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"city==%@",responseObject);
        NSMutableArray* mArr=[NSMutableArray array];
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CityListModel* model=[self ModelWithDict:obj];
            [mArr addObject:model];
        }];
        if (sBlock) {
            sBlock(mArr.copy);
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (eBlock) {
            eBlock();
        }
    }];
}
@end
