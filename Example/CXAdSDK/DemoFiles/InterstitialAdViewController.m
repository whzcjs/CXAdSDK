//
//  InterstitialAdViewController.m
//  CXAdSDKDemo
//
//  Created by AustinYang on 2025/6/27.
//

#import "InterstitialAdViewController.h"
#import <CXAdSDK/CXAdSDK.h>
#import <MBProgressHUD.h>
#import <Toast.h>

@interface InterstitialAdViewController ()<CXInterstitialAdDelegate>
@property (strong, nonatomic) CXInterstitialAd *cx_interstitialAd;

@end

@implementation InterstitialAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"插屏广告";
}

- (IBAction)onLoadAd:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.cx_interstitialAd loadAdData];
}

- (IBAction)onShowAd:(id)sender {
    [self.cx_interstitialAd showFromViewController:self];
}

#pragma mark -getter

- (CXInterstitialAd *)cx_interstitialAd {
    if (!_cx_interstitialAd) {
        _cx_interstitialAd = [[CXInterstitialAd alloc] initWithPlacementId:kInterstitialId];
        _cx_interstitialAd.delegate = self;
    }
    return _cx_interstitialAd;
}


#pragma mark -CXInterstitialAdDelegate
/// 插屏广告加载成功
- (void)cx_interstitialAdLoadSuccess:(CXInterstitialAd *)interstitialAd {
    NSLog(@"--------------%s", __FUNCTION__);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.view makeToast:@"广告加载成功"];
}

/// 插屏广告加载失败
- (void)cx_interstitialAdLoadFail:(CXInterstitialAd *)interstitialAd error:(NSError *)error {
    NSLog(@"--------------%s----error = %@", __FUNCTION__, error);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.view makeToast:[NSString stringWithFormat:@"加载失败 error = %@", error]];
}

/// 插屏广告曝光
- (void)cx_interstitialAdDidShow:(CXInterstitialAd *)interstitialAd {
    NSLog(@"--------------%s", __FUNCTION__);
}

/// 插屏广告点击
- (void)cx_interstitialAdDidClick:(CXInterstitialAd *)interstitialAd {
    NSLog(@"--------------%s", __FUNCTION__);
}

/// 插屏广告关闭
- (void)cx_interstitialAdDidClose:(CXInterstitialAd *)interstitialAd {
    NSLog(@"--------------%s", __FUNCTION__);
}


@end
