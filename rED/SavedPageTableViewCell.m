//
//  SavedPageTableViewCell.m
//  rED
//
//  Created by Cole Smith on 4/15/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "SavedPageTableViewCell.h"

@implementation SavedPageTableViewCell
@synthesize webView;

- (void)awakeFromNib {
    // Initialization code
    webView.scrollView.scrollEnabled = NO;
    webView.scrollView.bounces = NO;
    [self initWebViewMask];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

- (void)initWebViewMask {
    CAGradientLayer *maskLayer = [CAGradientLayer layer];
    maskLayer.colors = @[
                         (id)[UIColor whiteColor].CGColor,
                         (id)[UIColor whiteColor].CGColor,
                         (id)[UIColor clearColor].CGColor];
    maskLayer.locations = @[ @0.0f, @0.2f, @1.0f ];
    maskLayer.frame = webView.bounds;
    webView.layer.mask = maskLayer;
}

@end
