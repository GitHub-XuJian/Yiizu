//
//  UIImage+Extension.h
//  电视直播
//
//  Created by 邵峰 on 2016/10/27.
//  Copyright © 2016年 邵峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  图片不要渲染
 *
 *  @param name 图片名字
 *
 *  @return 返回一张不要渲染的图片
 */
+ (UIImage *)imageWithRenderOriginalName:(NSString *)name;


@end
