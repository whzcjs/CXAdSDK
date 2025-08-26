//
//  CXViewController.m
//  CXAdSDK
//
//  Created by AustinYang on 08/26/2025.
//  Copyright (c) 2025 AustinYang. All rights reserved.
//

#import "CXViewController.h"
#import <CXAdSDK/CXAdSDK.h>
#import "AdTypeListModel.h"

//#import <MBProgressHUD.h>

@interface CXViewController ()<CXSplashAdDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray <AdTypeListModel *>*contentList;
@property (strong, nonatomic) CXSplashAd *splashAd;

@end

@implementation CXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.contentList = [AdTypeListModel getDataList];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    AdTypeListModel *listModel = self.contentList[indexPath.row];
    cell.textLabel.text = listModel.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AdTypeListModel *listModel = self.contentList[indexPath.row];
    switch (listModel.adType) {
        case AdTypeSplash:
        {
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self.splashAd loadAd];
        }
            break;
            
//        case AdTypeBanner:
//        {
//            BannerViewController *vc = BannerViewController.new;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//            
//        case AdTypeInterstitial:
//        {
//            InterstitialAdViewController *vc = InterstitialAdViewController.new;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//        case AdTypeNativeExpress:
//        {
//            NativeExpressAdViewController *vc = NativeExpressAdViewController.new;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//            
//        case AdTypeNative:
//        {
//            NativeAdViewController *vc = NativeAdViewController.new;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//            
//        case AdTypeRewardVideo:
//        {
//            RewardVideoViewController *vc = RewardVideoViewController.new;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
            
        default:
            break;
    }
}


- (CXSplashAd *)splashAd {
    if (!_splashAd) {
        _splashAd = [[CXSplashAd alloc] initWithPlacementId:kSplashId];
        _splashAd.delegate = self;
        _splashAd.viewController = self;
    }
    return _splashAd;
}

#pragma mark -CXSplashAdDelegate
- (void)cx_splashAdDidLoad:(CXSplashAd *)splashAd {
    NSLog(@"---------------广告加载成功");

    [self.splashAd showAdInWindow: self.view.window];
}
/**
 *  开屏广告展示失败
 */
- (void)cx_splashAdFailToPresent:(CXSplashAd *)splashAd withError:(NSError *)error {
    NSLog(@"---------------广告加载失败 = %@", error);
}

- (void)cx_splashAdSuccessPresentScreen:(CXSplashAd *)splashAd {
    NSLog(@"---------------开屏广告成功展示");
}

/**
 *  开屏广告曝光回调
 */
- (void)cx_splashAdExposured:(CXSplashAd *)splashAd {
    NSLog(@"----------------开屏广告曝光");
}

/**
 *  开屏广告将要关闭回调
 */
- (void)cx_splashAdWillClosed:(CXSplashAd *)splashAd {
    NSLog(@"-----------------开屏广告将要关闭");
}

/**
 *  开屏广告关闭回调
 */
- (void)cx_splashAdClosed:(CXSplashAd *)splashAd {
    NSLog(@"-----------------开屏广告已经关闭");
}

/**
 *  开屏广告点击回调
 */
- (void)cx_splashAdClicked:(CXSplashAd *)splashAd {
    NSLog(@"------------------开屏广告点击");
}

- (void)cx_splashAdLifeTime:(NSUInteger)time {
    
}


@end
