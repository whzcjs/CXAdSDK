//
//  NativeAdMoreImageListCell.m
//  CXAdSDKDemo
//
//  Created by AustinYang on 2025/8/5.
//

#import "NativeAdMoreImageView.h"
#import <Masonry.h>
#import <SDWebImage.h>

@interface NativeAdMoreImageView ()
@property (strong, nonatomic) NSArray<NSString *> *urls;
@end

@implementation NativeAdMoreImageView

- (instancetype)initWithUrls:(NSArray<NSString *> *)urls {
    if (self = [super init]) {
        self.urls = urls;
        
        self.backgroundColor = UIColor.whiteColor;
        
        NSInteger count = urls.count;
        if (count == 0) return self;
        
        UIView *lastImageView = nil;
        CGFloat spacing = 5.0;
        
        for (NSInteger i = 0; i < count; i++) {
            NSString *urlStr = urls[i];
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.clipsToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.backgroundColor = UIColor.lightGrayColor;
            [self addSubview:imageView];
            
            // 加载图片
            NSURL *url = [NSURL URLWithString:urlStr];
            [imageView sd_setImageWithURL:url placeholderImage:nil];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                
                if (lastImageView) {
                    make.left.equalTo(lastImageView.mas_right).offset(spacing);
                    make.width.equalTo(lastImageView); 
                } else {
                    make.left.equalTo(self);
                }
                
                if (i == count - 1) {
                    make.right.equalTo(self);
                }
            }];
            
            lastImageView = imageView;
        }
    }
    return self;
}

@end
