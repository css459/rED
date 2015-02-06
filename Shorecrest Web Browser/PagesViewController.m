//
//  PagesViewController.m
//  Shorecrest Web Browser
//
//  Created by Cole Smith on 2/3/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "PagesViewController.h"
#import "ColorPalette.h"

@interface PagesViewController ()
{
    BOOL savedButtonState;
    ColorPalette *cp;
}
@end

@implementation PagesViewController
@synthesize button_SavePageProp;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        savedButtonState = false;
        cp = [[ColorPalette alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// Hides the Navigation Bar on appearance
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

// Displays the Navigation Bar on disappearance
- (void)viewDidDisappear: (BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewDidDisappear:animated];
}

// Allows user to exit editing
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

// Handles toggling of saved button
- (IBAction)button_SavePage:(id)sender {
    if (!savedButtonState) {
        savedButtonState = true;
        if (savedButtonState) {
            [button_SavePageProp setImage:[UIImage imageNamed:@"toolbar_Save_Clicked"]];
        }
    } else {
        [button_SavePageProp setImage:[UIImage imageNamed:@"toolbar_Save_Unclicked"]];
    }
    savedButtonState = false;
}
@end
