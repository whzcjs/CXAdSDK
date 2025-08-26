//
//  SplashAdDelegate.h
//  CXAdSDKSample
//
//  Created by AustinYang on 2025/8/25.
//

#import <Foundation/Foundation.h>
#import <CXAdSDK/CXAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface SplashAdDelegate : NSObject<CXSplashAdDelegate>

- (instancetype)initWithWithWindow: (UIWindow *)window
                         cxSplash: (CXSplashAd *)cxSplash;

@property (copy, nonatomic) void(^compeleteBlock)(void);

@end

NS_ASSUME_NONNULL_END
