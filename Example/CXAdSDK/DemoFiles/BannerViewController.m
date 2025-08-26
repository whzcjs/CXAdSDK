//
//  BannerViewController.m
//  CXAdSDKDemo
//
//  Created by AustinYang on 2025/6/16.
//

#import "BannerViewController.h"

#import <CXAdSDK/CXAdSDK.h>

#import <MBProgressHUD.h>
#import <Toast.h>

@interface BannerViewController ()<CXBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bannerBackView;
@property (strong, nonatomic) CXBannerView *cx_bannerView;

@end

@implementation BannerViewController

- (void)dealloc
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.cyanColor;
    
    [self.cx_bannerView loadAdAndShow];
}

- (IBAction)onLoadAd:(id)sender {
    [self.cx_bannerView removeFromSuperview];
    [self.cx_bannerView loadAdAndShow];
}

- (CXBannerView *)cx_bannerView {
    if (!_cx_bannerView) {
        _cx_bannerView = [[CXBannerView alloc] initWithFrame:CGRectMake(0,
                                                                          0,
                                                                          UIScreen.mainScreen.bounds.size.width,
                                                                          100)
                                                   placementId:kBannerId
                                                viewController:self];
        _cx_bannerView.delegate = self;
        _cx_bannerView.autoSwitchInterval = 30;
    }
    return _cx_bannerView;
}

#pragma mark -CXBannerViewDelegate
- (void)cx_bannerViewWillClose:(CXBannerView *)bannerView {
    NSLog(@"--------------%s", __func__);
}

- (void)cx_bannerViewDidLoad:(CXBannerView *)bannerView {
    if (!self.cx_bannerView.superview) {
        [self.bannerBackView addSubview:self.cx_bannerView];
    }
    NSLog(@"--------------%s", __func__);
}

- (void)cx_bannerViewFailedToLoad:(CXBannerView *)bannerView error:(NSError *)error {
    NSLog(@"------------------------banner加载失败 error = %@", error);
}

/**
 *  banner曝光回调
 */
- (void)cx_bannerViewWillExpose:(CXBannerView *)bannerView {
    NSLog(@"--------------%s", __func__);
    [self.view makeToast:@"banner exposed"];
}

/**
 *  banner点击回调
 */
- (void)cx_bannerViewClicked:(CXBannerView *)bannerView {
    NSLog(@"--------------%s", __func__);
}
@end
