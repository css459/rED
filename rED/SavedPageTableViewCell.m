//
//  SavedPageTableViewCell.m
//  rED
//
//  Created by Cole Smith on 4/15/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "SavedPageTableViewCell.h"

@interface SavedPageTableViewCell ()
{
    NSTimer *timer;
    float value;
}
@end

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

// May implement Autoscrool later
//-(void)scroll {
//    
//    NSLog(@"tick");
//    
//    float scrollVal = 0.0f;
//    CGPoint bottomOffset = CGPointMake(0, self.webView.scrollView.contentSize.height - self.webView.scrollView.bounds.size.height);
//    
//    if (scrollVal < bottomOffset.y) {
//        
//        CGPoint scroll = CGPointMake(0, scrollVal);
//        scrollVal += 1;
//        
//        [self.webView.scrollView setContentOffset:scroll animated:YES];
//        webView.scrollView.bounces = NO;
//        
//    } else {
//        
//        [timer invalidate];
//        timer = nil;
//        
//    }
//}
//
//-(void)autoScrollInvocation {
//    
//    value = -.1*(5) + .5;
//    timer = [NSTimer
//             scheduledTimerWithTimeInterval:value
//             target:self
//             selector:@selector(scroll)
//             userInfo:nil
//             repeats:YES];
//    
//}

@end
