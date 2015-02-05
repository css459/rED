//
//  PagesViewController.m
//  Shorecrest Web Browser
//
//  Created by Cole Smith on 2/3/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "PagesViewController.h"

@interface PagesViewController ()

@end

@implementation PagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Hides the Navigation Bar on appearance
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

// Displays the Navigation Bar on disappearance
- (void)viewDidDisappear: (BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewDidDisappear:animated];
}

@end
