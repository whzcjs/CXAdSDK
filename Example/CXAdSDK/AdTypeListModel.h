//
//  AdTypeListModel.h
//  CXAdSDKDemo
//
//  Created by AustinYang on 2025/7/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AdType) {
    AdTypeSplash,
    AdTypeBanner,
    AdTypeInterstitial,
    AdTypeNativeExpress,
    AdTypeNative,
    AdTypeRewardVideo,
};

@interface AdTypeListModel : NSObject
@property (assign, nonatomic) AdType adType;
@property (copy, nonatomic) NSString *title;

- (instancetype)initWithAdType: (AdType)adType title: (NSString *)title;

+ (NSMutableArray <AdTypeListModel *>*)getDataList;
@end

NS_ASSUME_NONNULL_END
