//
//  NativeAdViewController.m
//  CXAdSDKDemo
//
//  Created by AustinYang on 2025/7/8.
//

#import "NativeAdViewController.h"
#import "NativeAdListCell.h"
#import <MBProgressHUD.h>
#import <Toast.h>

#import <CXAdSDK/CXAdSDK.h>

@interface NativeAdViewController ()<
UITableViewDataSource,
UITableViewDelegate,
CXNativeAdsManagerDelegate,
CXNativeAdDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) CXNativeAdsManager *cx_nativeAdManager;
@property (strong, nonatomic) NSMutableArray<CXNativeAd *> *cx_adDataArray;
@end

@implementation NativeAdViewController

- (void)dealloc
{
    NSLog(@"--------%@----dealloc", self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"信息流自渲染广告";
    self.view.backgroundColor = UIColor.orangeColor;
    [self.tableView registerNib:[UINib nibWithNibName:@"NativeAdListCell" bundle:nil] forCellReuseIdentifier:@"NativeAdListCell"];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"加载广告" style:(UIBarButtonItemStylePlain) target:self action:@selector(loadAd)];
    self.cx_adDataArray = NSMutableArray.array;
    
    [self loadAd];
}

- (void)loadAd {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.cx_nativeAdManager loadAdWithAdCount:1];
    
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cx_adDataArray.count * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        NativeAdListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NativeAdListCell"];
        [cell setNativeAdDataCX:self.cx_adDataArray[indexPath.row / 2]];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.contentView.backgroundColor = UIColor.lightGrayColor;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return NativeAdListCell.cellHeight;
    }
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -getter

- (CXNativeAdsManager *)cx_nativeAdManager {
    if (!_cx_nativeAdManager) {
        _cx_nativeAdManager = [[CXNativeAdsManager alloc] initWithPlacementId:kNativeAd];
        _cx_nativeAdManager.delegate = self;
    }
    return _cx_nativeAdManager;
}

#pragma mark -CXNativeAdDelegate
- (void)cx_nativeAdsManagerSuccessToLoad:(CXNativeAdsManager *)adsManager nativeAds:(NSArray<CXNativeAd *> *)nativeAdDataArray {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"---------------%s, 自渲染广告数据加载成功",__FUNCTION__);
    //        self.cx_adDataArray = nativeAdDataArray.mutableCopy;
    [self.cx_adDataArray addObjectsFromArray:nativeAdDataArray];
    [self.tableView reloadData];
    for (CXNativeAd *obj in nativeAdDataArray) {
        //        NSLog(@"extraInfo: %@", obj.extraInfo);
        obj.viewController = self;
        obj.delegate = self;
    }
}

- (void)cx_nativeAdsManager:(CXNativeAdsManager *)adsManager didFailWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"-------------%s ad load fail: %@",__FUNCTION__,error);
    [self.view makeToast:error.localizedDescription];
}

#pragma mark -CXNativeAdDelegate
- (void)cx_nativeAdViewExposure:(CXNativeAd *)nativeAd {
    NSLog(@"-------------广告曝光");
}

- (void)cx_nativeAdViewClicked:(CXNativeAd *)nativeAd {
    NSLog(@"---------广告点击");
}


@end
