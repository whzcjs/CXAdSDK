//
//  CXAppDelegate.m
//  CXAdSDK
//
//  Created by AustinYang on 08/26/2025.
//  Copyright (c) 2025 AustinYang. All rights reserved.
//

#import "CXAppDelegate.h"
#import <CXAdSDK/CXAdSDK.h>

@interface CXAppDelegate ()<CXSplashAdDelegate>
@property (strong, nonatomic) CXSplashAd *splashAd;
@end

@implementation CXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSString *sdkVersion = [CXAdSDKManager sdkVersion];
    NSLog(@"sdk 版本号 = %@", sdkVersion);
    
    BOOL result = [CXAdSDKManager initWithAppId:kAppId secretKey:kSecretKey];
    if (result) {
        [CXAdSDKManager startWithCompletionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                self.splashAd = [[CXSplashAd alloc] initWithPlacementId:kSplashId];
                self.splashAd.delegate = self;
                self.splashAd.viewController = self.window.rootViewController;
                [self.splashAd loadAd];
            }
        }];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -CXSplashAdDelegate
- (void)cx_splashAdDidLoad:(CXSplashAd *)splashAd {
    NSLog(@"---------------广告加载成功");

    [self.splashAd showAdInWindow: self.window];
}
/**
 *  开屏广告展示失败
 */
- (void)cx_splashAdFailToPresent:(CXSplashAd *)splashAd withError:(NSError *)error {
    NSLog(@"---------------广告加载失败 = %@", error);
}

- (void)cx_splashAdSuccessPresentScreen:(CXSplashAd *)splashAd {
    NSLog(@"---------------开屏广告成功展示");
}

/**
 *  开屏广告曝光回调
 */
- (void)cx_splashAdExposured:(CXSplashAd *)splashAd {
    NSLog(@"----------------开屏广告曝光");
}

/**
 *  开屏广告将要关闭回调
 */
- (void)cx_splashAdWillClosed:(CXSplashAd *)splashAd {
    NSLog(@"-----------------开屏广告将要关闭");
}

/**
 *  开屏广告关闭回调
 */
- (void)cx_splashAdClosed:(CXSplashAd *)splashAd {
    NSLog(@"-----------------开屏广告已经关闭");
}

/**
 *  开屏广告点击回调
 */
- (void)cx_splashAdClicked:(CXSplashAd *)splashAd {
    NSLog(@"------------------开屏广告点击");
}

- (void)cx_splashAdLifeTime:(NSUInteger)time {
    
}


@end
