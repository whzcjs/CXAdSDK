//
//  CXBannerView.h
//  CXAdSDK
//
//  Created by AustinYang on 2025/6/16.
//

#import <UIKit/UIKit.h>
#import <CXAdSDK/CXAdProtocol.h>

NS_ASSUME_NONNULL_BEGIN
@class CXBannerView;
@protocol CXBannerViewDelegate <NSObject>
@optional
/**
 *  请求广告条数据成功后调用
 *  当接收服务器返回的广告数据成功后调用该函数
 */
- (void)cx_bannerViewDidLoad:(CXBannerView *)bannerView;

/**
 *  请求广告条数据失败后调用
 *  当接收服务器返回的广告数据失败后调用该函数
 */
- (void)cx_bannerViewFailedToLoad:(CXBannerView *)bannerView error:(NSError *)error;

/**
 *  banner曝光回调
 */
- (void)cx_bannerViewWillExpose:(CXBannerView *)bannerView;

/**
 *  banner点击回调
 */
- (void)cx_bannerViewClicked:(CXBannerView *)bannerView;

/**
 *  banner被用户关闭时调用
 *  会立即关闭当前banner广告，若启用轮播，（刷新间隔 - 当前广告已展示时间）后会展示新的广告
 *  若未启用轮播或不需要再展示，需在回调中将annerView从父view移除置nil
 */
- (void)cx_bannerViewWillClose:(CXBannerView *)bannerView;


@end

@interface CXBannerView : UIView<CXAdProtocol>

/**
 *  委托 [可选]
 */
@property (nonatomic, weak) id<CXBannerViewDelegate> delegate;

/**
 *  广告刷新间隔，范围 [30, 120] 秒，默认值 30 秒。设 0 则不刷新。 [可选]
 */
@property (nonatomic) int autoSwitchInterval;

/**
 *  构造方法
 *  详解：frame - banner 展示的位置和大小
 *       placementId - 广告位 ID
 *       viewController - 视图控制器
 */
- (instancetype)initWithFrame:(CGRect)frame
                  placementId:(NSString *)placementId
               viewController:(UIViewController *)viewController;

/**
 *  拉取并展示广告
 */
- (void)loadAdAndShow;

/**
 返回广告的eCPM，单位：分
 
 @return 成功返回一个大于等于0的值，-1表示无权限或后台出现异常
 */
- (NSInteger)eCPM;
@end

NS_ASSUME_NONNULL_END
