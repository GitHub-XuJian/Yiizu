//
//  EncapsulationMethod.m
//  MagicFigure
//
//  Created by 徐健 on 16/12/28.
//  Copyright © 2016年 XuJian. All rights reserved.
//

#import "EncapsulationMethod.h"
#import <objc/runtime.h>
#import<CommonCrypto/CommonDigest.h>

@interface EncapsulationMethod ()


@end
@implementation EncapsulationMethod


+(EncapsulationMethod *)sharedManager{
    static dispatch_once_t predicate;
    static EncapsulationMethod * sharedManager;
    dispatch_once(&predicate, ^{
        sharedManager=[[EncapsulationMethod alloc] init];
    });
    return sharedManager;
}
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content{
    
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    
    if (![emailTest evaluateWithObject:content]) {
        
        return YES;
        
    }
    
    return NO;
    
}
/***
 *  返回当前视图控制器
 */
+ (UIViewController *)viewController:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
// View转image
- (UIImage*) imageWithUIView:(UIView*) view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}
// 合成两个image
- (UIImage *)syntheticWithimageOne:(UIImage *)image1 andImageTwo:(UIImage *)image2
{
    CGSize size = CGSizeMake(70, 70);
    UIGraphicsBeginImageContext(size);
    [image1 drawInRect:CGRectMake(5, 5, 40, 40)];
    [image2 drawInRect:CGRectMake(25, 25, 40, 40)];
    UIImage *togetherImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return togetherImage;
}
// 根据字符内容计算宽度
+ (CGFloat)calculateRowWidth:(NSString *)string andFont:(NSInteger)size andHight:(CGFloat)hight{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, hight)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}
// 根据字符内容计算高度
+ (CGFloat)calculateRowHeight:(NSString *)textStr andTexFont:(NSInteger )size andMaxWidth:(CGFloat)width
{
    NSDictionary *textAttDict = @{NSFontAttributeName : [UIFont systemFontOfSize:size]};
    CGRect rect = [textStr boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttDict context:nil];
    return rect.size.height;

}
/*!
 * @brief 把对象（Model）转换成字典
 * @param model 模型对象
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithModel:(id)model {
    if (model == nil) {
        return nil;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    // 获取类名/根据类名获取类对象
    NSString *className = NSStringFromClass([model class]);
    id classObject = objc_getClass([className UTF8String]);
    
    // 获取所有属性
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(classObject, &count);
    
    // 遍历所有属性
    for (int i = 0; i < count; i++) {
        // 取得属性
        objc_property_t property = properties[i];
        // 取得属性名
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)
                                                          encoding:NSUTF8StringEncoding];
        // 取得属性值
        id propertyValue = nil;
        id valueObject = [model valueForKey:propertyName];
        
        if ([valueObject isKindOfClass:[NSDictionary class]]) {
            propertyValue = [NSDictionary dictionaryWithDictionary:valueObject];
        } else if ([valueObject isKindOfClass:[NSArray class]]) {
            NSMutableArray *twoArray = [NSMutableArray array];
            [valueObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *twoDict = [self dictionaryWithModel:obj];
                [twoArray addObject:twoDict];
            }];
            propertyValue = twoArray;
        } else {
            NSString *valueStr = [model valueForKey:propertyName];
            if (valueStr == nil) {
                valueStr = @"";
            }
            
            propertyValue = [NSString stringWithFormat:@"%@", valueStr];
        }
        
        [dict setObject:propertyValue forKey:propertyName];
    }
    return [dict copy];
}
+(NSString *)dictToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        DLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
+ (NSString *)arrayToJSONString:(NSArray *)array
{
    NSError *error = nil;
    //    NSMutableArray *muArray = [NSMutableArray array];
    //    for (NSString *userId in array) {
    //        [muArray addObject:[NSString stringWithFormat:@"\"%@\"", userId]];
    //    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    DLog(@"json array is: %@", jsonResult);
    return jsonString;
}
// 将JSON串转化为字典或者数组
+ (id)toArrayOrNSDictionary:(NSString *)jsonStr{
    
    NSData *nsData=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:nsData
                                                    options:NSJSONReadingAllowFragments
                                                      error:nil];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}
+(NSString*)changeTelephone:(NSString*)teleStr{
    
    NSRange range = [teleStr rangeOfString:@"@"];
    NSMutableString* string=[[NSMutableString alloc]initWithString:teleStr];//存在堆区，可变字符串
    [string insertString:@"***"atIndex:range.length];
    DLog(@"string:%@",string);
    return string;
    
}
+(NSDictionary *)getObjectData:(id)obj {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++){
        objc_property_t prop = props[i];
        
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil){
            value = [NSNull null];
        }else{
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}
+(id)getObjectInternal:(id)obj
{
    if([obj
        isKindOfClass:[NSString class]]
       
       ||
       [obj isKindOfClass:[NSNumber class]]
       
       ||
       [obj isKindOfClass:[NSNull class]])
        
    {
        
        return
        
        obj;
        
    }
    
    
    
    if([obj
        isKindOfClass:[NSArray class]])
        
    {
        
        NSArray
        *objarr = obj;
        
        NSMutableArray
        *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int
            i = 0;i < objarr.count; i++)
            
        {
            
            [arr
             setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
            
        }
        
        return
        
        arr;
        
    }
    
    
    
    if([obj
        isKindOfClass:[NSDictionary class]])
        
    {
        
        NSDictionary
        *objdic = obj;
        
        NSMutableDictionary
        *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        
        for(NSString
            *key in
            
            objdic.allKeys)
            
        {
            
            [dic
             setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
            
        }     
        
        return
        
        dic;
        
    } 
    
    return
    
    [self getObjectData:obj];
    
}
+(NSDate *)dateWithString:(NSString *)str
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:str];
    return date;
}
+(NSString *)stringWithDate:(NSDate *)date
{
    DLog(@"%@",date);//2015-11-20 00:37:40 +0000
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    
    //    dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss";//指定转date得日期格式化形式
    //
    //    DLog(@"%@",[dateFormatter stringFromDate:date]);//2015-11-20 08:24:04
    
    dateFormatter.dateFormat=@"yyyy-MM-dd";
    
    DLog(@"%@",[dateFormatter stringFromDate:date]);//2015-11-20
    
    //    dateFormatter.dateFormat=@"yyyy-MM-dd eeee aa HH:mm:ss";
    //
    //    DLog(@"%@",[dateFormatter stringFromDate:date]);//2015-11-20 Friday AM 08:30:28
    //
    //    dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss z";
    //
    //    DLog(@"%@",[dateFormatter stringFromDate:date]);//2015-11-20 08:42:22 GMT+8
    //
    return [dateFormatter stringFromDate:date];
}


/**
 * 一个时间距现在的时间,返回天数
 */
+ (NSString *)intervalSinceNow: (NSString *) theDate
{

    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    //根据updateTime的格式，写出对应的日期格式化串
    [format setDateFormat:@"YYYY-MM-dd HH:mm"];
    [format setLocale:[NSLocale currentLocale]];
    NSDate *currentDate = [format dateFromString:theDate];
    
    //获取当前的系统时间
    NSDate *date = [NSDate date];
    //消除8小时的误差。
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    
    //追加8小时
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    currentDate = [currentDate dateByAddingTimeInterval:interval];
    //计算时间差间隔
    NSTimeInterval timeBetween = [localeDate timeIntervalSinceDate:currentDate];
    NSInteger numberDays = timeBetween/(24 * 3600);
    
    return [NSString stringWithFormat:@"%ld",(long)numberDays];
}
+(NSString *)timeStrWithTimeStamp:(NSString *)timeStr
{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    return currentDateString;
}
+(NSString *)timeStrWithTimeStampMinutes:(NSString *)timeStr
{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    return currentDateString;
}
//获取当前的时间
+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    DLog(@"currentTimeString =  %@",currentTimeString);
    /**
     * 时间戳
     */
//    NSString *timeSp = [NSString stringWithFormat:@"%d", (long)[datenow timeIntervalSince1970]];
//    DLog(@"timeSp:%@",timeSp); //时间戳的值
    return currentTimeString;
    
}
/**
 * 开始到结束的时间差
 */
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startD =[date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int second = (int)value %60;//秒
    int minute = (int)value /60%60;
    int house = (int)value / (24 * 3600)%3600;
    int day = (int)value / (24 * 3600);
    NSString *str;
    if (day != 0) {
        str = [NSString stringWithFormat:@"耗时%d天%d小时%d分%d秒",day,house,minute,second];
    }else if (day==0 && house != 0) {
        str = [NSString stringWithFormat:@"耗时%d小时%d分%d秒",house,minute,second];
    }else if (day== 0 && house== 0 && minute!=0) {
        str = [NSString stringWithFormat:@"耗时%d分%d秒",minute,second];
    }else{
        str = [NSString stringWithFormat:@"耗时%d秒",second];
    }
    return str;
}
-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}
//颜色转换图片
+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+(void)settingLabelTextAttributesWithLineSpacing:(CGFloat)lineSpacing FirstLineHeadIndent:(CGFloat)firstLineHeadIndent FontOfSize:(CGFloat)fontOfSize TextColor:(UIColor *)textColor text:(NSString *)text AddLabel:(id)label{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    //行间距
    
    paragraphStyle.lineSpacing = lineSpacing;
    
    //首行缩进 (缩进个数 * 字号)
    
    paragraphStyle.firstLineHeadIndent = firstLineHeadIndent * fontOfSize;
    
    NSDictionary *attributeDic = @{
                                   
                                   NSFontAttributeName : [UIFont systemFontOfSize:fontOfSize],
                                   
                                   NSParagraphStyleAttributeName : paragraphStyle,
                                   
                                   NSForegroundColorAttributeName : textColor
                                   
                                   };
    if ([label isKindOfClass:[UILabel class]]) {
        UILabel *label1 = label;
        label1.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributeDic];
    }else if ([label isKindOfClass:[UITextView class]]){
        UITextView *textView = label;
        textView.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributeDic];
    }    
}
//计算UILabel的高度(带有行间距的情况)
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width LineSpacing:(CGFloat)lineSpacing;
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpacing;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}
+ (void)callPhoneStr:(NSString*)phoneStr{
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneStr];
    NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
    if (compare == NSOrderedDescending || compare == NSOrderedSame) {
        /// 大于等于10.0系统使用此openURL方法
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
    
}
//邮箱地址的正则表达式
+ (BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//银行卡的正则表达式
+ (BOOL)isValidateBankCard:(NSString *)bankCard{
    NSString *bankCardRegex = @"^\\d{19}$";
    NSPredicate *bankCardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", bankCardRegex];
    return [bankCardTest evaluateWithObject:bankCard];
}
//身份证的正则表达式
+ (BOOL)isIdCardCard:(NSString *)userID{
    //长度不为18的都排除掉
    if (userID.length!=18) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
}
//电话号码的正则表达式
+ (BOOL)isValidatePhone:(NSString *)phone{
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phone.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:phone];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:phone];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:phone];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

+ (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
@end
