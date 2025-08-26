//
//  NativeAdListCell.h
//  CXAdSDKDemo
//
//  Created by AustinYang on 2025/7/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CXNativeAd;
@interface NativeAdListCell : UITableViewCell

- (void)setNativeAdDataCX: (CXNativeAd *)nativeAdData;

+ (CGFloat)cellHeight;
@end

NS_ASSUME_NONNULL_END
