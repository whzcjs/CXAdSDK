//
//  AdTypeListModel.m
//  CXAdSDKDemo
//
//  Created by AustinYang on 2025/7/8.
//

#import "AdTypeListModel.h"

@implementation AdTypeListModel
- (instancetype)initWithAdType:(AdType)adType title:(NSString *)title {
    if (self = [super init]) {
        self.adType = adType;
        self.title = title;
    }
    return self;
}

+ (NSMutableArray <AdTypeListModel *>*)getDataList {
    NSMutableArray <AdTypeListModel *>*array = NSMutableArray.array;
    
    AdTypeListModel *splashModel = [[AdTypeListModel alloc] initWithAdType:(AdTypeSplash) title:@"开屏广告"];
    [array addObject:splashModel];
    
    AdTypeListModel *bannerModel = [[AdTypeListModel alloc] initWithAdType:(AdTypeBanner) title:@"banner广告"];
    [array addObject:bannerModel];
    
    AdTypeListModel *interstitialModel = [[AdTypeListModel alloc] initWithAdType:(AdTypeInterstitial) title:@"插屏广告"];
    [array addObject:interstitialModel];
    
    AdTypeListModel *nativeExpressModel = [[AdTypeListModel alloc] initWithAdType:(AdTypeNativeExpress) title:@"信息流模版广告"];
    [array addObject:nativeExpressModel];
    
    AdTypeListModel *nativeModel = [[AdTypeListModel alloc] initWithAdType:(AdTypeNative) title:@"信息流自渲染广告"];
    [array addObject:nativeModel];
    
    AdTypeListModel *rewardVideoModel = [[AdTypeListModel alloc] initWithAdType:(AdTypeRewardVideo) title:@"激励视频广告"];
    [array addObject:rewardVideoModel];
    
    return array;
}
@end
