//
//  NativeAdListCell.m
//  CXAdSDKDemo
//
//  Created by AustinYang on 2025/7/9.
//

#import "NativeAdListCell.h"
#import <SDWebImage/SDWebImage.h>
#import <Masonry.h>

#import <CXAdSDK/CXAdSDK.h>
#import "NativeAdMoreImageView.h"

@interface NativeAdListCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adImageWidth;
@property (weak, nonatomic) IBOutlet UIImageView *adImageView;
@property (weak, nonatomic) IBOutlet UILabel *adTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *adDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *appDetailLabel;

@property (strong, nonatomic) CXNativeAd *cx_nativeAdData;

@property (strong, nonatomic) UIView *adLogoView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *buttonTitleLabel;


@property (strong, nonatomic) NativeAdMoreImageView *moreImageView;

@end

@implementation NativeAdListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setNativeAdDataCX:(CXNativeAd *)nativeAdData {
    if (_cx_nativeAdData != nativeAdData) {
        
        [_cx_nativeAdData unregisterView];
        if (self.adLogoView.superview == self.contentView) {
            [self.adLogoView removeFromSuperview];
        }
        
        _cx_nativeAdData = nativeAdData;
        
        CXNativeAdDataObject *adDataObject = _cx_nativeAdData.dataObject;
        
        [self.adImageView sd_setImageWithURL:[NSURL URLWithString:adDataObject.imageUrl]];
        CGFloat radio = (CGFloat)adDataObject.imageWidth / adDataObject.imageHeight;
        self.adImageWidth.constant = [self.class cellHeight] * radio;
        self.adTitleLabel.text = adDataObject.title;
        self.adDescLabel.text = adDataObject.desc;
        self.appDetailLabel.text = adDataObject.appName;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:adDataObject.iconUrl]];
                        
        self.buttonTitleLabel.text = adDataObject.interactionTitle;
        
        [self.moreImageView removeFromSuperview];
        if (adDataObject.isThreeImgsAd) {
            self.moreImageView = [[NativeAdMoreImageView alloc] initWithUrls:adDataObject.mediaUrlList];
            [self.contentView addSubview:self.moreImageView];
            [self.moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView);
            }];
            [_cx_nativeAdData registerContainer:self.contentView withClickableViews:@[self.moreImageView]];
        }
        else {
            [_cx_nativeAdData registerContainer:self.contentView withClickableViews:@[self.adImageView]];
        }
        
        self.adLogoView = nativeAdData.adLogoView;
        [self.contentView addSubview:self.adLogoView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.adLogoView.frame = CGRectMake(0, self.bounds.size.height - self.adLogoView.bounds.size.height, self.adLogoView.bounds.size.width, self.adLogoView.bounds.size.height);
    
}

+ (CGFloat)cellHeight {
    return 70;
}

@end
