//
//  PagesViewController.m
//  rED
//
//  Created by Cole Smith on 2/3/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "PagesViewController.h"
#import "ColorPalette.h"
#import "SavedPagesTableViewController.h"
#import "NotesViewController.h"

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

// This method was commented out for incorrect behavior with the Auto Scroll Navigation Bar

//// Displays the Navigation Bar on disappearance
//- (void)viewDidDisappear: (BOOL)animated {
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//    [super viewDidDisappear:animated];
//}

// Allows user to exit editing
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

// Handles toggling of saved button
- (IBAction)button_SavePage:(id)sender {
    savedButtonState = !savedButtonState;
    if (savedButtonState) {
        [button_SavePageProp setImage:[UIImage imageNamed:@"toolbar_Save_Clicked"]];
        // Here, the Page obj should be added to the cell array.
    } else {
        [button_SavePageProp setImage:[UIImage imageNamed:@"toolbar_Save_Unclicked"]];
        // Here, the Page obj should be removed from the cell array.
    }
}

//These methods may or may not be needed depending on the segue type set in the storyboard

// Switch to Saved Pages
- (IBAction)gesture_SwipeRight:(id)sender {
    NSLog(@"swipe right");
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle bundleForClass:[self class]]];
    SavedPagesTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SavedPagesTableViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
}

// Switch to Notebook
- (IBAction)gesture_SwipeLeft:(id)sender {
    NSLog(@"swipe left");
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle bundleForClass:[self class]]];
    NotesViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"NotesViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
}

@end
