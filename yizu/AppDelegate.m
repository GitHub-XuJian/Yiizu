//
//  AppDelegate.m
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "AppDelegate.h"
#import "SFRootVC.h"
#import "IQKeyboardManager.h"
#import "LoginViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "ActivationCodeInputViewController.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()<UIApplicationDelegate,WXApiDelegate>

@end

@implementation AppDelegate

//设置单例
+ (AppDelegate *)shareDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear]; //设置HUD背景图层的样式
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 30.0f; // 输入框距离键盘的距离
    /**
     * 微信APPID
     */
    [WXApi registerApp:WXDoctor_App_ID];
    
    /**
     * 友盟
     */
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [SFRootVC chooseWindowRootVC];
    [self.window makeKeyAndVisible];
    return YES;
}

//获取Window当前显示的ViewController
- (UIViewController*)currentViewController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}
- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXPatient_App_ID appSecret:WXPatient_App_Secret redirectURL:@"http://www.umeng.com/social"];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQPatient_App_ID/*设置QQ平台的appID*/  appSecret:QQPatient_App_Secret redirectURL:@"http://www.umeng.com/social"];
   
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        NSLog(@"支付");
        if ([url.host isEqualToString:@"safepay"]) {
            // 支付跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService]
             processOrderWithPaymentResult:url
             standbyCallback:^(NSDictionary *resultDic) {
                 NSLog(@"result = %@",resultDic);//返回的支付结果
                 if ([resultDic[@"resultStatus"] integerValue] == 9000) {
                     NSNotification *notification =[NSNotification notificationWithName:@"ZhiFuBaoPayNotification" object:resultDic userInfo:nil];
                     [[NSNotificationCenter defaultCenter] postNotification:notification];
                 }else{
                     jxt_showAlertTitle(resultDic[@"memo"]);
                 }
                 
             }];
        }
        if ([url.host isEqualToString:@"pay"]){
            //微信支付，处理支付结果
            return [WXApi handleOpenURL:url delegate:self];
        }
    }
    
    return result;
}
/**
 * 微信支付返回结果，通知在商城类里做操作
 */
-(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        NSLog(@"%@",response.returnKey);
        NSNotification *notification =[NSNotification notificationWithName:@"WeiXinPayNotification" object:resp userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}
/**
 * 验证版本号
 */
- (void)verifyVersion
{
    NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Login/explain",Main_Server];
    [XAFNetWork GET:urlStr params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        // 1.获取当前版本号
        NSString *currVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        /**
         * 服务器版本号
         */
        NSString *lastVersion = responseObject[@"edition"];
        if (![currVersion isEqualToString:lastVersion]) {
            jxt_showAlertOneButton(responseObject[@"prompt"], responseObject[@"replace"], @"确定", ^(NSInteger buttonIndex) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=%@&mt=8",AppStore_ID]] options:@{} completionHandler:nil];
                // 这里写的URL地址是该app在app store里面的下载链接地址，其中ID是该app在app store对应的唯一的ID编号。
            });
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

/**
 * 每次进入应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self verifyVersion];

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}







@end
