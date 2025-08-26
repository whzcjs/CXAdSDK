//
//  CXNativeAdDataObject.h
//  CXAdSDK
//
//  Created by AustinYang on 2025/7/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CXNativeAdDataObject : NSObject

/**
 广告标题
 */
@property (nonatomic, copy, readonly) NSString * _Nullable title;

/**
 广告描述
 */
@property (nonatomic, copy, readonly) NSString * _Nullable desc;

/**
 素材图片宽度
 */
@property (nonatomic, readonly) NSInteger imageWidth;

/**
 素材图片高度
 */
@property (nonatomic, readonly) NSInteger imageHeight;

/**
 应用类广告App 图标Url
 */
@property (nonatomic, copy, readonly) NSString * _Nullable iconUrl;

/**
 应用类广告App name
 */
@property (nonatomic, copy, readonly) NSString * _Nullable appName;

/**
 广告图片Url
 */
@property (nonatomic, copy, readonly) NSString * _Nullable imageUrl;

/**
 广告图片集合
 */
@property (nonatomic, copy, readonly) NSArray * _Nullable mediaUrlList;

/**
 * 广告事件交互标题
 */
@property (nonatomic, readonly) NSString * _Nullable interactionTitle;

/**
 是否为视频广告
 */
@property (nonatomic, readonly) BOOL isVideoAd;

/**
 是否为三小图广告
 */
@property (nonatomic, readonly) BOOL isThreeImgsAd;

/**
 视频地址
 */
@property (nonatomic, readonly) NSString * _Nullable videoUrl;

/**
 * 视频广告时长，单位 s
 */
@property (nonatomic, readonly) CGFloat duration;

/**
 返回广告的eCPM，单位：分
 
 @return 成功返回一个大于等于0的值，-1表示无权限或后台出现异常
 */
@property (nonatomic, readonly) NSInteger eCPM;

@end

