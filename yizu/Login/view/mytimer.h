//
//  mytimer.h
//  text
//
//  Created by Yansu on 16/4/9.
//  Copyright © 2016年 Yansu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mytimer : NSTimer

@property (nonatomic,assign)int time;

+(instancetype)sharetimer;

-(void)makeTimer;
-(BOOL)checkTimer;
-(void)stopTimer;
@end
