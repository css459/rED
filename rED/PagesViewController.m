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
#import "SettingsViewController.h"
#import "AutoScrollViewController.h"
#import "Settings.h"
#import "AppDelegate.h"

@interface PagesViewController ()
{
    // States
    BOOL savedButtonState;
    BOOL nightModeState;
    BOOL settingsButtonState;
    
    // Utility Objects
    ColorPalette *cp;
    Settings *userSettings;
    UISlider *slider_textSize;
    
    // Button Arrays
    NSArray *array_toolbarButtons;
    NSArray *array_settingsToolbarButtons;
    NSArray *array_defaultToolbarButtons;
    
    // Default Buttons
    UIBarButtonItem *button_savePage;
    UIBarButtonItem *button_autoScroll;
    UIBarButtonItem *button_action;
    UIBarButtonItem *button_defaultSettings;
    
    // Settings-State Buttons
    UIBarButtonItem *button_more;
    UIBarButtonItem *button_textSize;
    UIBarButtonItem *button_nightMode;
    UIBarButtonItem *button_expandedSettings;
    
    
}
@end

@implementation PagesViewController
@synthesize button_Slot1, button_Slot2, button_Slot3, button_Settings, searchBar, webView, url, htmlContent, htmlDictionary;

#pragma mark - Initalizers

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        savedButtonState = NO;
        settingsButtonState = NO;
        nightModeState = NO;
        
        cp = [[ColorPalette alloc] init];
        userSettings = [Settings sharedSettings];
        slider_textSize = [[UISlider alloc] init];
        
        button_Slot1 = [[UIBarButtonItem alloc] init];
        button_Slot2 = [[UIBarButtonItem alloc] init];
        button_Slot3 = [[UIBarButtonItem alloc] init];
        button_Settings = [[UIBarButtonItem alloc] init];
        
        button_more = [[UIBarButtonItem alloc] init];
        button_nightMode = [[UIBarButtonItem alloc] init];
        button_textSize = [[UIBarButtonItem alloc] init];
        button_expandedSettings = [[UIBarButtonItem alloc] init];
        
        button_savePage = [[UIBarButtonItem alloc] init];
        button_autoScroll = [[UIBarButtonItem alloc] init];
        button_action = [[UIBarButtonItem alloc] init];
        button_defaultSettings = [[UIBarButtonItem alloc] init];;
        
        [button_more setImage:[UIImage imageNamed:@"settingsToolbar_More"]];
        [button_nightMode setImage:[UIImage imageNamed:@"settingsToolbar_NightMode_Clicked"]];
        [button_textSize setImage:[UIImage imageNamed:@"settingsToolbar_TextSize_Unclicked"]]; // This needs fixing
        [button_expandedSettings setImage:[UIImage imageNamed:@"toolbar_SettingsGear_Clicked"]];
        
        [button_savePage setImage:[UIImage imageNamed:@"toolbar_Save_Unclicked"]]; // This will need to be dynamic
        [button_autoScroll setImage:[UIImage imageNamed:@"toolbar_AutoScroll_Unclicked"]];
        [button_action setImage:[UIImage imageNamed:@"settingsToolbar_TextSize_Unclicked"]]; // This needs fixing
        [button_defaultSettings setImage:[UIImage imageNamed:@"toolbar_SettingsGear_Unclicked"]];
        
        array_toolbarButtons = @[button_Slot1, button_Slot2, button_Slot3, button_Settings];
        array_defaultToolbarButtons = @[button_savePage, button_autoScroll, button_action, button_defaultSettings];
        array_settingsToolbarButtons = @[button_more, button_nightMode, button_textSize, button_expandedSettings];
        
        slider_textSize.minimumValue = 9;
        slider_textSize.maximumValue = 72;
        
        [self getHTML:[userSettings homeSite]];
    }
    return self;
}

#pragma mark - View Handlers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Swipe Declarations
    UISwipeGestureRecognizer * swipeLeft = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(gesture_SwipeLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(gesture_SwipeRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
}

- (void)viewWillAppear:(BOOL)animated {
    // Hides the Navigation Bar on appearance
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)refreshView:(NSNotification *) notification {
    [self viewDidLoad];
    [self viewWillAppear:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action Handlers

// Allows user to exit editing
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

// Switch to Notebook
- (void)gesture_SwipeLeft:(UISwipeGestureRecognizer*)gestureRecognizer {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard
                                storyboardWithName:storyboardName
                                bundle:[NSBundle bundleForClass:[self class]]];
    
    NotesViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"NotesViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
}

// Switch to Saved Pages
- (void)gesture_SwipeRight:(UISwipeGestureRecognizer*)gestureRecognizer {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard
                                storyboardWithName:storyboardName
                                bundle:[NSBundle bundleForClass:[self class]]];
    
    SavedPagesTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SavedPagesTableViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
}

#pragma mark - Button Actions

- (IBAction)button_Slot1WasPressed:(id)sender {
    if (settingsButtonState) {
        // Settings ACTIVE
        [self button_savePageWasPressed];
        
    } else {
        // Normal state
        [self button_moreWasPressed];
    }
}

- (IBAction)button_Slot2WasPressed:(id)sender {
    if (settingsButtonState) {
        // Settings ACTIVE
        [self button_autoScrollWasPressed];
    } else {
        // Normal State
        [self button_nightModeWasPressed];
    }
}

- (IBAction)button_Slot3WasPressed:(id)sender {
    if (settingsButtonState) {
        // Settings ACTIVE
        [self button_textSizeWasPressed];
    } else {
        // Normal State
        [self button_actionWasPressed];
    }
}

- (IBAction)button_SettingsWasPressed:(id)sender {
    settingsButtonState = !settingsButtonState;
    if (settingsButtonState) {
        // Swap to expanded settings
        [self button_expandedSettingsWasPressed];
    } else {
        // Swap to default settings
        [self button_defaultSettingsWasPressed];
    }
}

#pragma mark - Contexual Button Methods

// Toggle saving of the Page Object
- (void)button_savePageWasPressed {
    savedButtonState = !savedButtonState;
    if (savedButtonState) {
        [button_Slot1 setImage:[UIImage imageNamed:@"toolbar_Save_Clicked"]];
        // Here, the Page obj should be ADDED to the cell array.
    } else {
        [button_Slot1 setImage:[UIImage imageNamed:@"toolbar_Save_Unclicked"]];
        // Here, the Page obj should be REMOVED from the cell array.
    }
    [self button_FadeOut:button_Slot1];
}

// Present the Auto Scroll View Controller
- (void)button_autoScrollWasPressed {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard
                                storyboardWithName:storyboardName
                                bundle:[NSBundle bundleForClass:[self class]]];
    
    AutoScrollViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"AutoScrollViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
}

// Handle sharing of Page Object and Notebook Object, depending on settings.
- (void)button_actionWasPressed {
    #warning incomplete implementation
}

// Switch to expanded settings state
- (void)button_defaultSettingsWasPressed {
    settingsButtonState = YES;
    [self loadInToolbarItems:array_settingsToolbarButtons];
    [self refreshView:nil];
}

// Present the Settings View Controller
- (void)button_moreWasPressed {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard
                                storyboardWithName:storyboardName
                                bundle:[NSBundle bundleForClass:[self class]]];
    
    SettingsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
}

// Toggle Night Mode
- (void)button_nightModeWasPressed {
    nightModeState = !nightModeState;
    if (nightModeState) {
        [cp changeColorProfile:@"NightMode"];
        [self refreshView:nil];
    } else {
        [cp changeColorProfile:@"Default"];
        [self refreshView:nil];
    }
}

// Change Toolbar to slider and adjust the text size based on Slider value.
- (void)button_textSizeWasPressed {
    UIBarButtonItem *button_done = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                    target:self
                                    action:@selector(button_doneWasPressed:)];
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                   target:nil
                                   action:nil];
    [fixedSpace setWidth:10.0f];
    
    NSArray *array_SliderInterface = @[slider_textSize,fixedSpace,button_done];
    [self.navigationController.toolbar setItems:array_SliderInterface animated:YES];
    
}

// Switch back to normal state
- (void)button_expandedSettingsWasPressed {
    settingsButtonState = NO;
    [self loadInToolbarItems:array_defaultToolbarButtons];
    [self refreshView:nil];
}

#pragma mark - Supporting Methods

// Action for "Done Button" in "textSizeWasPressed" method
- (IBAction)button_doneWasPressed:(id)sender {
    [userSettings setTextSize:slider_textSize.value];
    [self loadInToolbarItems:array_defaultToolbarButtons];
    [self refreshView:nil];
}

// Switch the buttons in the toolbar for input array
- (void)loadInToolbarItems:(NSArray *)arrayToSet {
    array_toolbarButtons = arrayToSet;
    [self.navigationController.toolbar setItems:array_toolbarButtons animated:YES];
}

#pragma mark - HTML Handlers

// Called when URL search button is pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)sB {
    url = [NSString stringWithString:sB.text];
    
    // Formats the URL if it does not contain the "http://" prefix
    if ([url containsString:@"http://"]) {
        [self getHTML:url];
    } else {
        NSString *newUrl = [NSString stringWithFormat:@"http://%@", url];
        [self getHTML:newUrl];
    }
}

- (void)getHTML:(NSString *)URL {
    // URLString is the URL from which the data is downloaded from
    NSString *URLString = [NSString stringWithFormat:@"https://www.readability.com/api/content/v1/parser?url=%@&token=79df0f9969a83dfb8759ba33c4530d6d04ffe87f", URL];
    
    // NSString is converted to a NSURL
    NSURL *websiteUrl = [NSURL URLWithString:URLString];
    
    // Data download block
    [AppDelegate downloadDataFromURL:websiteUrl withCompletionHandler:^(NSData *data) {
        if (data != nil) {
            NSError *error;
            NSMutableDictionary *returnedDict = [NSJSONSerialization
                                                 JSONObjectWithData:data
                                                 options:kNilOptions
                                                 error:&error];
            if (error != nil) {
                NSLog(@"%@",[error localizedDescription]);
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"Uh-Oh!"
                                      message:@"The URL you requested is not compatible with rED :("
                                      delegate:nil
                                      cancelButtonTitle:@"Okay"
                                      otherButtonTitles:nil, nil];
                [alert show];
            } else {
                self.htmlDictionary = [returnedDict objectForKey:@"content"];
                
                // HTML Content property is set to contain the HTML code for the page
                self.htmlContent = [[self htmlDictionary] description];
                
                // HTML is opened in the UIWebView
                [self openHTML:htmlContent];
            }
        }
    }];
}

- (void)openHTML:(NSString *)html {
    //Loads UIWebView with HTML
    [webView loadHTMLString:html baseURL:nil];
}

# pragma mark - Custom Transitions

- (void)button_FadeOut:(UIBarButtonItem *)button {
   //[UIView animateWithDuration:0.25 animations:^{alpha = 0.0;}];
}

// We will worry about custom transitions later
/*
 - (void)customTransition {
 NSString * storyboardName = @"Main";
 UIStoryboard *storyboard = [UIStoryboard
 storyboardWithName:storyboardName
 bundle:[NSBundle bundleForClass:[self class]]];
 
 __block PagesViewController *sourceViewController = (UIViewController*)[self sourceViewController];
 __block SavedPagesTableViewController *destinationController = (UIViewController*)[self destinationViewController];
 
 CATransition* transition = [CATransition animation];
 transition.duration = .25;
 transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
 transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
 
 
 
 [sourceViewController.navigationController.view.layer addAnimation:transition
 forKey:kCATransition];
 
 [sourceViewController.navigationController pushViewController:destinationController animated:NO];
 }
 */

@end
