//
//  ActivityLsitModel.h
//  yizu
//
//  Created by myMac on 2017/11/8.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityLsitModel : NSObject

//activityid = 21;
//"city_id" = 76;
//"end_time" = 1970;
//"locus_id" = 839;
//mainpic = "2017-11-07/5a014070b424d.png";
//movable = 14214421421421321;
//pic =     (
//           "2017-10-16/59e473386bf11.jpg",
//           "2017-10-16/59e473386d681.jpg",
//           "2017-10-16/59e473386f5c1.jpg"
//           );
//region = 1;
//sort = 1421421;
//specific = A;
//"start_time" = 1970;
//title = 2142142;
//writingpic = 321321321;

@property (nonatomic, copy) NSString* mainpic;
@property (nonatomic, copy) NSString* writingpic ;
@property (nonatomic, copy) NSString* city_id;
//@property (nonatomic, copy) NSString* ;
//@property (nonatomic, copy) NSString* ;
//@property (nonatomic, copy) NSString* ;

+(instancetype)modelWithDict:(NSDictionary*)dic;

@end
