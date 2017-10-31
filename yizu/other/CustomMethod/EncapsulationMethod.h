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
 *  返回当前视图控制器
 */
+ (UIViewController *)viewController:(UIView *)view;
/**
 * 根据字符内容计算宽度
 */
+ (CGFloat)calculateRowWidth:(NSString *)string andFont:(NSInteger)size andHight:(CGFloat)hight;
/**
 * 根据字符内容计算高度
 */
+ (CGFloat)calculateRowHeight:(NSString *)textStr andTexFont:(NSInteger )size andMaxWidth:(CGFloat)width;
/**
 * Label首行缩进，行间距
 参数介绍
 
 lineSpacing (行间距)
 
 FirstLineHeadIndent(首行缩进字符个数)
 
 FontOfSize (字号)
 
 TextColor(字体颜色)
 
 text(字符串内容)
 
 AddLabel(在哪个LB上面使用该特性)
 
 */
+(void)settingLabelTextAttributesWithLineSpacing:(CGFloat)lineSpacing FirstLineHeadIndent:(CGFloat)firstLineHeadIndent FontOfSize:(CGFloat)fontOfSize TextColor:(UIColor *)textColor text:(NSString *)text AddLabel:(UILabel *)label;
/**
 * 计算UILabel的高度(带有行间距的情况)
 */
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width LineSpacing:(CGFloat)lineSpacing;
/**
 * 数组转json
 */
+ (NSString *)arrayToJSONString:(NSArray *)array;
/**
 * 字典转json
 */
+(NSString *)dictToJsonData:(NSDictionary *)dict;

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
