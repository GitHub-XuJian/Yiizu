//
//  UIImage+Extension.m
//  电视直播
//
//  Created by 邵峰 on 2016/10/27.
//  Copyright © 2016年 邵峰. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)imageWithRenderOriginalName:(NSString *)name{
    UIImage *image =  [UIImage imageNamed:name];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
