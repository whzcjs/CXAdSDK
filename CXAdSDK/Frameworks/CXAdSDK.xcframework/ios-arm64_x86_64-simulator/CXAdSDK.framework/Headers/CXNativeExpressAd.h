//
//  CXNativeExpressAd.h
//  CXAdSDK
//
//  Created by AustinYang on 2025/7/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CXNativeExpressAd;
@class CXNativeExpressAdView;

@protocol CXNativeExpressAdDelegate <NSObject>

@optional
/**
 * 拉取原生模板广告成功
 */
- (void)cx_nativeExpressAdSuccessToLoad:(CXNativeExpressAd *)nativeExpressAd views:(NSArray<__kindof CXNativeExpressAdView *> *)views;

/**
 * 拉取原生模板广告失败
 */
- (void)cx_nativeExpressAdFailToLoad:(CXNativeExpressAd *)nativeExpressAd error:(NSError *)error;

/**
 * 原生模板广告渲染成功, 此时的 nativeExpressAdView.size.height 根据 size.width 完成了动态更新。
 */
- (void)cx_nativeExpressAdViewRenderSuccess:(CXNativeExpressAdView *)nativeExpressAdView;

/**
 * 原生模板广告渲染失败
 */
- (void)cx_nativeExpressAdViewRenderFail:(CXNativeExpressAdView *)nativeExpressAdView;

/**
 * 原生模板广告曝光回调
 */
- (void)cx_nativeExpressAdViewExposure:(CXNativeExpressAdView *)nativeExpressAdView;

/**
 * 原生模板广告点击回调
 */
- (void)cx_nativeExpressAdViewClicked:(CXNativeExpressAdView *)nativeExpressAdView;

/**
 * 原生模板广告被关闭
 */
- (void)cx_nativeExpressAdViewClosed:(CXNativeExpressAdView *)nativeExpressAdView;

/**
 * 点击原生模板广告以后即将弹出全屏广告页
 */
- (void)cx_nativeExpressAdViewWillPresentScreen:(CXNativeExpressAdView *)nativeExpressAdView;

/**
 * 点击原生模板广告以后弹出全屏广告页
 */
- (void)cx_nativeExpressAdViewDidPresentScreen:(CXNativeExpressAdView *)nativeExpressAdView;

/**
 * 全屏广告页将要关闭
 */
- (void)cx_nativeExpressAdViewWillDismissScreen:(CXNativeExpressAdView *)nativeExpressAdView;

/**
 * 全屏广告页被关闭
 */
- (void)cx_nativeExpressAdViewDidDismissScreen:(CXNativeExpressAdView *)nativeExpressAdView;

/**
 * 详解:当点击应用下载或者广告调用系统程序打开时调用
 */
- (void)cx_nativeExpressAdViewApplicationWillEnterBackground:(CXNativeExpressAdView *)nativeExpressAdView;

@end

@interface CXNativeExpressAd : NSObject
/**
 *  委托对象
 */
@property (nonatomic, weak) id<CXNativeExpressAdDelegate> delegate;


@property (nonatomic, readonly) NSString *placementId;

/**
 *  构造方法
 *  详解：placementId - 广告位 ID
 *       adSize - 广告展示的宽高
 */

- (instancetype)initWithPlacementId:(NSString *)placementId adSize:(CGSize)size;

/**
 *  拉取广告
 *  @param count 请求广告数量
 */
- (void)loadAd:(NSInteger)count;

- (NSString *)requestId;

@end

NS_ASSUME_NONNULL_END
