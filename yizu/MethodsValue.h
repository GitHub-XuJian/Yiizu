//
//  MethodsValue.h
//  MagicFigure
//
//  Created by 徐健 on 16/12/27.
//  Copyright © 2016年 XuJian. All rights reserved.
//

/***
 *  沙盒路径
 */
#define Sandbox_Path [(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)) lastObject]

#define WEAKSELF      __weak __typeof__(self) weakSelf = self;
#define kSCREEN_HEIGHT  MAX([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)
#define kSCREEN_WIDTH   MIN([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)
#define UserDefaults  [NSUserDefaults standardUserDefaults]

#define Project_Name [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey]
#define Project_VersionNumber [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]

/***
 *  服务器地址
 */
#define Main_Server @"http://47.104.18.18/index.php/"
//#define Main_Server @"http://192.168.0.112:8080/contactOne/"
// 主窗口
#define KeyWindow [UIApplication sharedApplication].keyWindow

//各种颜色宏定义
//rgb颜色
#define kSetColor(a, b, c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1.0]
//带有透明度的rgb颜色
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//主题颜色
#define MainColor kSetColor(47, 132, 210)
//字体颜色
#define kTITLETEXTCOLOR [UIColor colorWithRed:70 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1.0]
#define kMAIN_BACKGROUND_COLOR_new [UIColor colorWithRed:234.0/255.0 green:235.0/255.0 blue:236.0/255.0 alpha:1.0]
//导航条颜色
#define KColor_NavigationBar [UIColor colorWithRed:0.17f green:0.72f blue:0.96f alpha:1.00f]
//背景颜色
#define kMAIN_BACKGROUND_COLOR [UIColor colorWithRed:0.90f green:0.89f blue:0.87f alpha:1.00f];
//边框颜色
#define kBORDER_COLOR [UIColor colorWithRed:201/255.0 green:202/255.0 blue:203/255.0 alpha:1.0]
//比背景色亮一点的颜色
#define kLIGHT_BACKGROUND_COLOR [UIColor colorWithRed:247/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]
//与主题一致的字体颜色
#define kTHEME_TEXT_COLOR [UIColor colorWithRed:157/255.0 green:96/255.0 blue:6/255.0 alpha:1.0]
//统一整体颜色
#define kColorBackground [UIColor colorWithRed:246.0 / 255.0 green:246.0 / 255.0 blue:246.0 / 255.0 alpha:1.0f]
//白色
#define kWhiteColor [UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1.0f]
//深红色
#define  kRedTopNavColor   [UIColor colorWithRed:91.0 / 255.0 green:148.0 / 255.0 blue:206.0 / 255.0 alpha:1.0f]
//正文标题、正文颜色
#define kColorBody [UIColor colorWithRed:76.0 / 255.0 green:73.0 / 255.0 blue:72.0 / 255.0 alpha:1.0f]

//蓝色
#define kColorblue [UIColor colorWithRed:73.0 / 255.0 green:136.0 / 255.0 blue:202.0 / 255.0 alpha:1.0f]
//透明色
#define kClearColor [UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:0.0f]
//浅灰色字体颜色
#define kLightGrayTextColor [UIColor colorWithRed:186.0 / 255.0 green:186.0 / 255.0 blue:186.0 / 255.0 alpha:1.0f]
//边框和线条颜色
#define kColorLine [UIColor colorWithRed:222 / 255.0 green:222 / 255.0 blue:222 / 255.0 alpha:1.0]
//深蓝色
#define kColorDarkblue [UIColor colorWithRed:19.0 / 255.0 green:31.0 / 255.0 blue:80.0 / 255.0 alpha:1.0f]

// 设置字体大小的宏
#define kCommonWithFont(f) [UIFont systemFontOfSize:f]
#define kDefaultTextFont            18.f
//字体大小
//顶部标题（常规）
#define kFontTopTitle [UIFont systemFontOfSize:17.0]
//顶部标题（加粗）
#define kFontDetailTopBold [UIFont boldSystemFontOfSize:17.0];
#define kFontTopTitleBold [UIFont boldSystemFontOfSize:20.0]
//正文标题（常规）
#define kFontBodyTitle [UIFont systemFontOfSize:16.0]
//正文标题（加粗）
#define kFontBodyTitleBold [UIFont boldSystemFontOfSize:16.0]
//正文副标题（常规）
#define kFontBodySubtitle [UIFont systemFontOfSize:15.0]
//正文副标题（加粗）
#define kFontBodySubtitleBold [UIFont boldSystemFontOfSize:15.0]
//其他（常规）
#define kFontOther [UIFont systemFontOfSize:13.0]
//其他（加粗）
#define kFontOtherBold [UIFont boldSystemFontOfSize:13.0]
//小字（常规）
#define kFontMini [UIFont systemFontOfSize:9.0]
//小字（加粗）
#define kFontMiniBold [UIFont boldSystemFontOfSize:10.0]

// Cell常规高度
#define kTableViewCell_HEIGHT  60

// 自定义键盘高度
#define KEYBOARD_HEIGHT 316
#define KEYBOARDFiel_HEIGHT 256

/***
 *  登陆数据存储Key
 */
#define PhoneKey @"phoneKey"
#define Password  @"loginPassword"
#define UserIDKey @"userIDKey"
#define IsLogin @"isLogin"
#define UserIconImage @"userIconImage"
#define VerificationCode @"VerificationCode"
#define VerificationCodeTime @"VerificationCodeTime"

/**
 * 微信登录
 */
#define WXDoctor_App_ID @"wxc7e3e75f5072d5b7"  // 注册微信时的AppID
#define WXDoctor_App_Secret @"667ad8dffcc1042b0ccabfe7437c66e7" // 注册时得到的AppSecret
#define WXPatient_App_ID @"wxc7e3e75f5072d5b7"
#define WXPatient_App_Secret @"667ad8dffcc1042b0ccabfe7437c66e7"
#define WX_ACCESS_TOKEN @"access_token"
#define WX_OPEN_ID @"openid"
#define WX_REFRESH_TOKEN @"refresh_token"
#define WX_UNION_ID @"unionid"
#define WX_BASE_URL @"https://api.weixin.qq.com/sns"









