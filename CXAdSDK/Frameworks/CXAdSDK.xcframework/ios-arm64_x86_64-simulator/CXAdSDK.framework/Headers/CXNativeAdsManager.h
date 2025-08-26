//
//  CXNativeAdManager.h
//  CXAdSDK
//
//  Created by AustinYang on 2025/7/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CXNativeAdsManager, CXNativeAd;
@protocol CXNativeAdsManagerDelegate <NSObject>

- (void)cx_nativeAdsManagerSuccessToLoad:(CXNativeAdsManager *)adsManager nativeAds:(NSArray<CXNativeAd *> *_Nullable)nativeAdDataArray;

- (void)cx_nativeAdsManager:(CXNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error;

@end

@interface CXNativeAdsManager : NSObject
/**
 构造方法

 @param placementId 广告位ID
 @return CXNativeAd 实例
 */
- (instancetype)initWithPlacementId:(NSString *_Nullable)placementId;

@property (nonatomic, weak) id<CXNativeAdsManagerDelegate> delegate;

/**
 加载广告

 @param adCount 加载条数
 */
- (void)loadAdWithAdCount:(NSInteger)adCount;
/**
 广告位Id
 */
@property (nonatomic, readonly) NSString *placementId;

- (NSString *)requestId;
@end

NS_ASSUME_NONNULL_END
