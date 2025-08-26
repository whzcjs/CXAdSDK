//
//  CXNativeExpressAdView.h
//  CXAdSDK
//
//  Created by AustinYang on 2025/7/1.
//

#import <UIKit/UIKit.h>
#import <CXAdSDK/CXAdProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXNativeExpressAdView : UIView<CXAdProtocol>
/**
 * 是否渲染完毕
 */
@property (nonatomic, assign, readonly) BOOL isReady;

/**
 * 是否是视频模板广告
 */
@property (nonatomic, assign, readonly) BOOL isVideoAd;

/**
 *  viewControllerForPresentingModalView
 *  详解：[必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
 */
@property (nonatomic, weak) UIViewController *controller;

/**
 *  广告是否有效，以下情况会返回NO，建议在调用render之前判断
 *  a.广告过期
 *  b.广告已曝光
 */
@property (nonatomic, readonly) BOOL isAdValid;

/**
 *[必选]
 *原生模板广告渲染
 */
- (void)render;

/**
 * 视频模板广告时长，单位 s
 */
- (CGFloat)videoDuration;

/**
 * 视频模板广告已播放时长，单位 s
 */
- (CGFloat)videoPlayTime;

/**
 返回广告的eCPM，单位：分
 
 @return 成功返回一个大于等于0的值，-1表示无权限或后台出现异常
 */
- (NSInteger)eCPM;

@end

NS_ASSUME_NONNULL_END
