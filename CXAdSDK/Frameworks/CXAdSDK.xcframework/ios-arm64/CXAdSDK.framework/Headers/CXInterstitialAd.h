//
//  CXInterstitialAd.h
//  CXAdSDK
//
//  Created by AustinYang on 2025/6/27.
//

#import <Foundation/Foundation.h>
#import <CXAdSDK/CXAdProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@class CXInterstitialAd;
@protocol CXInterstitialAdDelegate <NSObject>
@optional

/// 插屏广告加载成功
- (void)cx_interstitialAdLoadSuccess:(CXInterstitialAd *)interstitialAd;

/// 插屏广告加载失败
- (void)cx_interstitialAdLoadFail:(CXInterstitialAd *)interstitialAd error:(NSError *)error;

/// 插屏广告曝光
- (void)cx_interstitialAdDidShow:(CXInterstitialAd *)interstitialAd;

/// 插屏广告点击
- (void)cx_interstitialAdDidClick:(CXInterstitialAd *)interstitialAd;

/// 插屏广告关闭
- (void)cx_interstitialAdDidClose:(CXInterstitialAd *)interstitialAd;

@end

@interface CXInterstitialAd : NSObject<CXAdProtocol>
/**
 *  委托对象
 */
@property (nonatomic, weak) id<CXInterstitialAdDelegate> delegate;

@property (nonatomic, readonly) NSString *placementId;

/**
 *  构造方法
 *  详解：placementId - 广告位 ID
 */
- (instancetype)initWithPlacementId:(NSString *)placementId;

/**
 *  广告发起请求方法
 *  详解：[必选]发起拉取广告请求
 */
- (void)loadAdData;

/**
 *  广告展示方法
 *  详解：[必选]发起展示广告请求, 必须传入用于显示插播广告的UIViewController
 */

- (void)showFromViewController:(UIViewController *)viewController;

/**
 返回广告的eCPM，单位：分

 @return 成功返回一个大于等于0的值，-1表示无权限或后台出现异常
 */
- (NSInteger)eCPM;

@end

NS_ASSUME_NONNULL_END
