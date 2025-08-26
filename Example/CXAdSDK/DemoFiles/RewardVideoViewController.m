//
//  RewardVideoViewController.m
//  CXAdSDKDemo
//
//  Created by AustinYang on 2025/6/13.
//

#import "RewardVideoViewController.h"
#import <MBProgressHUD.h>
#import <Toast.h>

#import <CXAdSDK/CXAdSDK.h>

@interface RewardVideoViewController ()<CXRewardVideoAdDelegate>
@property (strong, nonatomic) CXRewardVideoAd *cx_rewardVideoAd;

@end

@implementation RewardVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.title = @"激励视频广告";
}

- (IBAction)onLoadAd:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.cx_rewardVideoAd loadAd];
    
}

- (IBAction)onShowAd:(id)sender {
    if (self.cx_rewardVideoAd.isAdValid) {
        BOOL showSuccess = [self.cx_rewardVideoAd showAdFromRootViewController:self];
        if (!showSuccess) {
            [self.view makeToast:@"激励视频展示失败"];
        }
    }
    else {
        [self.view makeToast:@"广告不可展示"];
    }
}

- (CXRewardVideoAd *)cx_rewardVideoAd {
    if (!_cx_rewardVideoAd) {
        _cx_rewardVideoAd = [[CXRewardVideoAd alloc] initWithPlacementId:kRewardVideoId];
        _cx_rewardVideoAd.delegate = self;
    }
    return _cx_rewardVideoAd;
}

#pragma mark - CXRewardVideoAdDelegate

- (void)cx_rewardVideoAdDidLoad:(CXRewardVideoAd *)rewardedVideoAd {
    NSLog(@"-----------激励视频素材加载成功");
}

- (void)cx_rewardVideoAdVideoDidLoad:(CXRewardVideoAd *)rewardedVideoAd {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.view makeToast:@"----------广告视频加载成功"];
    NSLog(@"----------广告视频加载成功");
}

- (void)cx_rewardVideoAd:(CXRewardVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"---------------激励视频加载失败 = %@", error);
    [self.view makeToast:error.localizedDescription];
}

- (void)cx_rewardVideoAdDidPlayFinish:(CXRewardVideoAd *)rewardedVideoAd {
    [self.view.window makeToast:@"视频播放完成"];
    NSLog(@"---------------激励视频播放完成");
}

- (void)cx_rewardVideoAdDidRewardEffective:(CXRewardVideoAd *)rewardedVideoAd info:(NSDictionary *)info {
    [self.view.window makeToast:@"达到激励条件"];
    NSLog(@"----------------激励视频达到激励条件");
}


- (void)cx_rewardVideoAdWillVisible:(CXRewardVideoAd *)rewardedVideoAd {
    NSLog(@"--------------激励视频将要展示");
}


- (void)cx_rewardVideoAdDidExposed:(CXRewardVideoAd *)rewardedVideoAd {
    NSLog(@"----------------激励视频已经曝光");
}


- (void)cx_rewardVideoAdDidClose:(CXRewardVideoAd *)rewardedVideoAd {
    NSLog(@"------------------激励视频已经关闭");
}

- (void)cx_rewardVideoAdDidClicked:(CXRewardVideoAd *)rewardedVideoAd {
    NSLog(@"----------------激励视频点击");
}

- (void)cx_rewardVideoAd:(CXRewardVideoAd *)rewardedVideoAd didPlayFailWithError:(NSError *)error {
    NSLog(@"-----------------激励视频播放失败 error = %@", error);
}

@end
