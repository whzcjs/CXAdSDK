//
//  NativeExpressAdViewController.m
//  CXAdSDKDemo
//
//  Created by AustinYang on 2025/7/1.
//

#import "NativeExpressAdViewController.h"
#import <MBProgressHUD.h>
#import <Toast.h>
#import "NativeExpressAdViewCell.h"

#import <CXAdSDK/CXAdSDK.h>

#define kNativeExpressViewHeight 0//kScreenWidth / 3

// 用来测试的cell多余数量
#define kTestExternCellCount 0

@interface NativeExpressAdViewController ()<UITableViewDataSource, UITableViewDelegate, CXNativeExpressAdDelegate>
@property (strong, nonatomic) IBOutlet UIButton *loadButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CXNativeExpressAd *cx_nativeExpressAd;

@property (strong, nonatomic) NSMutableArray <__kindof UIView *>* expressViews;
@end

@implementation NativeExpressAdViewController

- (void)dealloc
{
    NSLog(@"---------------%@----------dealloc", NSStringFromClass(self.class));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"信息流模版广告";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NativeExpressAdViewCell" bundle:nil] forCellReuseIdentifier:@"NativeExpressAdViewCell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"加载广告" style:(UIBarButtonItemStylePlain) target:self action:@selector(onLoadAd:)];
}


- (IBAction)onLoadAd:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self.cx_nativeExpressAd loadAd:1];
    
}


#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kTestExternCellCount + self.expressViews.count * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < kTestExternCellCount) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"33"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"33"];
        }
        cell.textLabel.text = @(indexPath.row).stringValue;
        return cell;
    }
    if (indexPath.row % 2 == 0) {
        NativeExpressAdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NativeExpressAdViewCell"];
        
        UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
        if ([subView superview]) {
            [subView removeFromSuperview];
        }
        CXNativeExpressAdView *view = [self.expressViews objectAtIndex:(indexPath.row - kTestExternCellCount + 1) / 2];
        view.tag = 1000;
        [cell.contentView addSubview:view];
        
        cell.accessibilityIdentifier = @"nativeAd";
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"splitCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"splitcell"];
        }
        cell.backgroundColor = [UIColor grayColor];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < kTestExternCellCount) {
        return 100;
    }
    if (indexPath.row % 2 == 0) {
        UIView *view = [self.expressViews objectAtIndex:(indexPath.row - kTestExternCellCount + 1) / 2];
        //        NSLog(@"-----cell的高度 = %@", NSStringFromCGRect(view.bounds));
        return view.bounds.size.height;
    }
    else {
        return 20;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -CXNativeExpressAdDelegate

- (void)cx_nativeExpressAdSuccessToLoad:(CXNativeExpressAd *)nativeExpressAd views:(NSArray<__kindof CXNativeExpressAdView *> *)views {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"------信息流广告加载成功");
    [self.view makeToast:@"广告加载成功"];
    [views enumerateObjectsUsingBlock:^(__kindof CXNativeExpressAdView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.controller = self;
        [obj render];
    }];
    //    if (!self.expressViews) {
    //        NSMutableArray *adViews = views.mutableCopy;
    //        self.expressViews = adViews;
    //    }
    //    else {
    //        NSMutableArray *adViews = self.expressViews.mutableCopy;
    //        [adViews addObjectsFromArray:views];
    //        self.expressViews = adViews;
    //    }
    self.expressViews = views.mutableCopy;
    [self.tableView reloadData];
}

- (void)cx_nativeExpressAdFailToLoad:(CXNativeExpressAd *)nativeExpressAd error:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"------信息流广告加载失败  =  %@", error);
    [self.view makeToast:error.localizedDescription];
}

- (void)cx_nativeExpressAdViewClosed:(CXNativeExpressAdView *)nativeExpressAdView {
    NSLog(@"------信息流广告关闭");
    [self.expressViews removeObject:nativeExpressAdView];
    [self.tableView reloadData];
}

- (void)cx_nativeExpressAdViewRenderSuccess:(CXNativeExpressAdView *)nativeExpressAdView {
    [self.tableView reloadData];
    NSLog(@"---------------信息流广告渲染成功");
}

- (void)cx_nativeExpressAdViewExposure:(CXNativeExpressAdView *)nativeExpressAdView {
    NSLog(@"---------------信息流广告曝光");
}

- (void)cx_nativeExpressAdViewClicked:(CXNativeExpressAdView *)nativeExpressAdView {
    NSLog(@"--------------信息流广告点击");
}

- (CXNativeExpressAd *)cx_nativeExpressAd {
    if (!_cx_nativeExpressAd) {
        _cx_nativeExpressAd = [[CXNativeExpressAd alloc] initWithPlacementId:kNativeExpressAdId adSize:(CGSizeMake(kScreenWidth, kNativeExpressViewHeight))];
        _cx_nativeExpressAd.delegate = self;
    }
    return _cx_nativeExpressAd;
}


@end
