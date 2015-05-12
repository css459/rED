//
//  ThankYouViewController.m
//  rED
//
//  Created by Cole Smith on 2/5/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "ThankYouViewController.h"

@interface ThankYouViewController ()
@end

@implementation ThankYouViewController

#pragma mark - Initializers

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

#pragma mark - View Handlers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Implements custom title with formatting
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *naviTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    UIFont *titleFont = [UIFont fontWithName:@"Bodoni 72 Oldstyle" size:20.0];
    [naviTitle setText:@"Credits"];
    [naviTitle setFont:titleFont];
    [naviTitle setTextColor:[UIColor darkTextColor]];
    [naviTitle sizeToFit];
    self.navigationItem.titleView = naviTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)updateColorScheme {}

@end
