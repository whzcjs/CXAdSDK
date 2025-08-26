//
//  CXNativeAd.h
//  CXAdSDK
//
//  Created by AustinYang on 2025/7/8.
//

#import <Foundation/Foundation.h>
#import <CXAdSDK/CXNativeAdDataObject.h>
#import <CXAdSDK/CXAdProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@class CXNativeAd;
@protocol CXNativeAdDelegate <NSObject>

/**
 广告曝光回调

 @param nativeAd CXNativeAd 实例
 */
- (void)cx_nativeAdViewExposure:(CXNativeAd *)nativeAd;

/**
 广告点击回调

 @param nativeAd CXNativeAd 实例
 */
- (void)cx_nativeAdViewClicked:(CXNativeAd *)nativeAd;

@end

@interface CXNativeAd : NSObject<CXAdProtocol>

/**
 Ad material.
 */
@property (nonatomic, strong, readonly, nullable) CXNativeAdDataObject *dataObject;

/**
 The delegate for receiving state change messages.
 The delegate is not limited to viewcontroller.
 The delegate can be set to any object which conforming to <CXNativeAdDelegate>.
 */
@property (nonatomic, weak, readwrite, nullable) id<CXNativeAdDelegate> delegate;

/**
 *  viewControllerForPresentingModalView
 *  详解：开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
 */
@property (nonatomic, weak) UIViewController *viewController;

/**
 @warning 需要注意的是 该方法需要避免重复多次调用的情况
 @warning 当广告不需要展示并且销毁的时候，需要调用 -[CXNativeAd unregisterView]方法，即registerContainer方法需要与unregisterView方法成对调用
 
 @param containerView 承载广告的容器，必传
 @param clickableViews 可点击的视图数组，此数组内的广告元素才可以响应广告对应的点击事件
 */
- (void)registerContainer:(__kindof UIView *)containerView withClickableViews:(NSArray<__kindof UIView *> *)clickableViews;

/**
 注销数据对象，在 tableView、collectionView 等场景需要复用 CXNativeAd 时，
 需要在合适的时机，例如 cell 的 prepareForReuse 方法内执行 unregisterView 方法，
 将广告对象与 CXNativeAd 解绑，具体可参考示例 demo 的 NativeAdListCell 类
 */
- (void)unregisterView;

/**
 广告logo
 */
@property (nonatomic, readonly) UIView * _Nonnull adLogoView;

@end

NS_ASSUME_NONNULL_END

