//
//  CXAdProtocol.h
//  CXAdSDK
//
//  Created by AustinYang on 2025/7/9.
//

#import <Foundation/Foundation.h>

// 最高失败价格 - 竟胜后传入其它失败里面的最高失败价格
#define kHighestFailurePrice @"highestFailurePrice"

// 竞价失败后使用 - 竟胜的最高价格
#define kHighestWinPrice @"highestWinPrice"

// 竞价失败原因
#define kBindingFailureReason @"bindingFailureReason"

/// 竞价失败枚举
typedef NS_ENUM(NSInteger, CXBiddingLoseReason) {
    // 未知原因失败
    CXBiddingLoseReasonUnkonwn = 0,
    // 竞价过低
    CXBiddingLoseReasonBidTooLow = 100,
    // 响应超时
    CXBiddingLoseReasonResponseTimeout = 200,
    // 响应数据错误
    CXBiddingLoseReasonResponseDataError = 300,
    // 响应素材错误
    CXBiddingLoseReasonResponseMaterialsError = 301
};



@protocol CXAdProtocol <NSObject>

@optional
- (NSDictionary *)extraInfo;

- (NSString *)requestId;

/**
 *  竞胜之后调用, 需要在调用广告 show 之前调用
 *
 *  @param winInfo 竞胜信息 字典类型，支持的key为以下，注：key是个宏，在CXAdProtocol.h中有定义，可以参考demo中的使用方法

 *  kHighestFailurePrice：最高失败出价，值类型为NSString  *
 *
 */
- (void)sendWinNotificationWithInfo:(NSDictionary *)winInfo;

/**
 *  竞败之后或未参竞调用，旧的- (void)sendLossNotificationWithWinnerPrice:(NSInteger)price lossReason:(CXAdBiddingLossReason)reason winnerAdnID:(NSString *)adnID已废弃
 *
 *  @pararm lossInfo 竞败信息，字典类型，注：key是个宏，在CXAdProtocol.h中有定义，可以参考demo中的使用方法
 *  kHighestWinPrice ：竞胜价格 (单位: 分)，值类型为NSString *，选填
 *  kBindingFailureReason ：广告竞败原因，竞败原因参考枚举CXBiddingLoseReason中的定义，值类型为NSNumber *，必填
 */
- (void)sendLossNotificationWithInfo:(NSDictionary *)lossInfo;

@end

