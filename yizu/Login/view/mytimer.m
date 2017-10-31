//
//  mytimer.m
//  text
//
//  Created by Yansu on 16/4/9.
//  Copyright © 2016年 Yansu. All rights reserved.
//
#define Time_Num 60
#import "mytimer.h"

@implementation mytimer
static mytimer *timer = nil;
+(instancetype)sharetimer{
    
    if (!nil) {        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,^{
            
            timer = [[self alloc]init];
        });
    }
    return timer;
    
}
-(void)makeTimer{

    
    
   NSTimer *myt  =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(atimer:) userInfo:nil repeats:YES];
    self.time = Time_Num;
    [myt fire];
}
-(void)atimer:(mytimer *)atimer{

    int is;
    is = 0;
    _time--;
    if (!_time) {
        [atimer invalidate];
        is = 1;
    }
    NSDictionary *dic =@{@"time":[NSString stringWithFormat:@"%d",_time],
                         @"num":[NSString stringWithFormat:@"%d",is]};
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"mytimertongzhi" object:nil userInfo:dic];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
-(BOOL)checkTimer{

    if (self.time) {
        return NO;
    }else{
    
        return YES;
    }
}
@end
