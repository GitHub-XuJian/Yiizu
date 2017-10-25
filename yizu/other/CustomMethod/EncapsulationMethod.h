//
//  EncapsulationMethod.h
//  MagicFigure
//
//  Created by 徐健 on 16/12/28.
//  Copyright © 2016年 XuJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncapsulationMethod : NSObject

+(EncapsulationMethod *)sharedManager;

/**
 * 根据字符内容计算宽度
 */
+ (CGFloat)calculateRowWidth:(NSString *)string andFont:(NSInteger)size andHight:(CGFloat)hight;
/**
 * 根据字符内容计算高度
 */
+ (CGFloat)calculateRowHeight:(NSString *)textStr andTexFont:(NSInteger )size andMaxWidth:(CGFloat)width;
/**
 * 数组转json
 */
+ (NSString *)arrayToJSONString:(NSArray *)array;
/**
 * 检查非法字符串
 */
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content;
/**
 * 自定义转字典
 */
+(NSDictionary *)getObjectData:(id)obj;
/**
 * 将JSON串转化为字典或者数组
 */
+ (id)toArrayOrNSDictionary:(NSString *)jsonStr;
/**
 * 电话号码加密
 */
+(NSString*)changeTelephone:(NSString*)teleStr;
/**
 * date转字符串
 */
+(NSString *)stringWithDate:(NSDate *)date;
/**
 * 字符串转date
 */
+(NSDate *)dateWithString:(NSString *)str;
/**
 * 一个时间距现在的时间
 */
+ (NSString *)intervalSinceNow: (NSString *) theDate;
/**
 * 对比两个时间
 */
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;
/**
 * 获取当前的时间
 */
+(NSString*)getCurrentTimes;
/**
 * 邮箱正则表达式
 */
+ (BOOL)isValidateEmail:(NSString *)email;
/**
 * @brief 把对象（Model）转换成字典
 * @param model 模型对象
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithModel:(id)model;
@end
