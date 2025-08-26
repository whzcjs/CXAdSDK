//
//  SplashAdDelegate.m
//  CXAdSDKSample
//
//  Created by AustinYang on 2025/8/25.
//

#import "SplashAdDelegate.h"

#import <Toast.h>

@interface SplashAdDelegate ()
@property (weak, nonatomic) UIWindow *window;
@property (weak, nonatomic) CXSplashAd *cxSplashAd;
@end


@implementation SplashAdDelegate

- (void)dealloc
{
    NSLog(@"-------------------%@ --------- dealloc", NSStringFromClass(self.class));
}

- (instancetype)initWithWithWindow:(UIWindow *)window
                         cxSplash:(CXSplashAd *)cxSplash {
    if (self = [super init]) {
        self.window = window;
        self.cxSplashAd = cxSplash;
    }
    return self;
}

#pragma CXSplashAdDelegate
- (void)cx_splashAdDidLoad:(CXSplashAd *)splashAd {
    NSLog(@"---------------广告加载成功");
    if (self.compeleteBlock) {
        self.compeleteBlock();
    }
    [self.cxSplashAd showAdInWindow: self.window];
}
/**
 *  开屏广告展示失败
 */
- (void)cx_splashAdFailToPresent:(CXSplashAd *)splashAd withError:(NSError *)error {
    NSLog(@"---------------广告加载失败 = %@", error);
    if (self.compeleteBlock) {
        self.compeleteBlock();
    }
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
