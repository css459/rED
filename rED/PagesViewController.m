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
#import "Page.h"
#import "SettingsViewController.h"

@interface PagesViewController ()
{
    // States
    BOOL savedButtonState;
    BOOL nightModeState;
    
    // Utility Objects
    ColorPalette *cp;
    Settings *userSettings;
    
    // Button Arrays
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
    
    UIBarButtonItem *flexibleSpace;
    
    
}
@end

@implementation PagesViewController
@synthesize searchBar, webView, url, htmlContent, htmlDictionary, updateHTML, slider_textSize, highlightColor, pageHtml, savedHtml, button_done;

#pragma mark - Initalizers

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        savedButtonState = NO;
        nightModeState = NO;
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat sliderWidth = .786 * screenRect.size.width;
        CGRect frame = CGRectMake(0, 0, sliderWidth, 32);
        
        cp = [[ColorPalette alloc] init];
        userSettings = [Settings sharedSettings];
        slider_textSize = [[UISlider alloc] initWithFrame:frame];
        
        [slider_textSize addTarget:self
                         action:@selector(slider_textSizeValueChanged:)
                         forControlEvents:UIControlEventValueChanged];
        
         button_done = [[UIBarButtonItem alloc]
                        initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                        target:self
                        action:@selector(button_doneWasPressed:)];
        
        button_more = [[UIBarButtonItem alloc]
                       initWithImage:[UIImage imageNamed:@"settingsToolbar_More"]
                       style:UIBarButtonItemStylePlain
                       target: self
                       action:@selector(button_moreWasPressed:)];
        
        button_nightMode = [[UIBarButtonItem alloc]
                            initWithImage:[UIImage imageNamed:@"settingsToolbar_NightMode_Clicked"]
                            style:UIBarButtonItemStylePlain
                            target:self
                            action:@selector(button_nightModeWasPressed:)];
        
        button_textSize = [[UIBarButtonItem alloc]
                           initWithImage:[UIImage imageNamed:@"settingsToolbar_TextSize_Unclicked"]
                           style:UIBarButtonItemStylePlain
                           target:self
                           action:@selector(button_textSizeWasPressed:)];
        
        button_expandedSettings = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"toolbar_SettingsGear_Clicked"]
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(button_expandedSettingsWasPressed:)];
        
        button_savePage = [[UIBarButtonItem alloc]
                           initWithImage:[UIImage imageNamed:@"toolbar_Save_Unclicked"]
                           style:UIBarButtonItemStylePlain
                           target:self
                           action:@selector(button_savePageWasPressed:)];
        
        button_autoScroll = [[UIBarButtonItem alloc]
                             initWithImage:[UIImage imageNamed:@"toolbar_AutoScroll_Unclicked"]
                             style:UIBarButtonItemStylePlain
                             target:self
                             action:@selector(button_autoScrollWasPressed:)];
        
        button_action = [[UIBarButtonItem alloc]
                         initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                         target:self
                         action:@selector(button_actionWasPressed:)];
        
        button_defaultSettings = [[UIBarButtonItem alloc]
                                  initWithImage:[UIImage imageNamed:@"toolbar_SettingsGear_Unclicked"]
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(button_defaultSettingsWasPressed:)];
        
        flexibleSpace = [[UIBarButtonItem alloc]
                         initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                         target:nil
                         action:nil];
        
        array_defaultToolbarButtons = @[button_savePage, flexibleSpace, button_autoScroll, flexibleSpace,
                                        button_action, flexibleSpace, button_defaultSettings];
        
        array_settingsToolbarButtons = @[button_more, flexibleSpace, button_nightMode, flexibleSpace,
                                         button_textSize, flexibleSpace, button_expandedSettings];


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
    
    // Toolbar Configurations
    [self.navigationController.toolbar setTintColor:[cp tint_accent]];
    [self.navigationController.toolbar setBarTintColor:[cp tint_background]];
    [self setToolbarItems:array_defaultToolbarButtons];
    [self.navigationController.toolbar setItems:array_defaultToolbarButtons animated:YES];
    
    // Slider Implementation
    slider_textSize.minimumValue = 9;
    slider_textSize.maximumValue = 72;
    slider_textSize.value = 12;
    slider_textSize.continuous = YES;
    
    [self.view setUserInteractionEnabled:YES];
    [self.view addSubview:self.slider_textSize];
    [self.slider_textSize setHidden:YES];
    
//    self.slider_textSize.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [self.view addConstraint:[NSLayoutConstraint
//                              constraintWithItem:self.slider_textSize
//                              attribute:NSLayoutAttributeLeft
//                              relatedBy:NSLayoutRelationEqual
//                              toItem:self.view
//                              attribute:NSLayoutAttributeLeft
//                              multiplier:1
//                              constant:5]];
//    
//    [self.view addConstraint:[NSLayoutConstraint
//                              constraintWithItem:self.slider_textSize
//                              attribute:NSLayoutAttributeRight
//                              relatedBy:NSLayoutRelationEqual
//                              toItem:button_done attribute:NSLayoutAttributeRight
//                              multiplier:1
//                              constant:10]];
    
    UIMenuItem *highlightRedItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"Red Highlight", nil) action:@selector(highlight_red)];
    UIMenuItem *highlightYellowItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"Yellow Highlight", nil) action:@selector(highlight_yellow)];
    UIMenuItem *highlightBlueItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"Blue Highlight", nil) action:@selector(highlight_blue)];
    UIMenuItem *highlightOrangeItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"Orange Highlight", nil) action:@selector(highlight_orange)];
    
    [UIMenuController sharedMenuController].menuItems = @[highlightRedItem, highlightYellowItem, highlightBlueItem , highlightOrangeItem];
}

- (void)viewWillAppear:(BOOL)animated {
    // Hides the Navigation Bar on appearance
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
    // Codes to adjust text size in UIWebView
    Settings *settings = [Settings sharedSettings];
    if (htmlContent != nil) {
        // Convert settings text size to HTML text size
        double size = [settings textSize];
        if (size >= 1 && size <= 10) {
            size = 1;
        }
        if (size >= 11 && size <= 20) {
            size = 2;
        }
        if (size >= 21 && size <= 30) {
            size = 3;
        }
        if (size >= 31 && size <= 40) {
            size = 4;
        }
        if (size >= 41 && size <= 50) {
            size = 5;
        }
        if (size >= 51 && size <= 60) {
            size = 6;
        }
        if (size >= 61) {
            size = 7;
        }
    
        // Update HTML
        NSString *updatedHTML = [NSString stringWithFormat:@"<font size=\"%f\">%@</font>", size, htmlContent];
        updateHTML = updatedHTML;
        
        // Reload webview html content
        [self openHTML:updateHTML];
    }
    
    // Codes to change UIWebView to night mode
    if (htmlContent != nil && [settings nightMode]) {
        NSString *updatedHTML = [NSString
                                 stringWithFormat:@"<body bgcolor=\"grey\"><font color=\"white\">%@</font></body>", updateHTML];
        
        [[self view]setBackgroundColor:[UIColor grayColor]];
        
        [self openHTML:updatedHTML];
    } else {
        [[self view]setBackgroundColor:[UIColor whiteColor]];
    }
    
    [self.navigationController setToolbarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)updateColorScheme {
    [searchBar setBarTintColor:[cp tint_background]];
    [searchBar setBackgroundColor:[cp tint_background]];
    [searchBar setTintColor:[cp tint_accent]];
    
    [self.navigationController.toolbar setTintColor:[cp tint_accent]];
    [self.navigationController.toolbar setBarTintColor:[cp tint_background]];
    
    NSString *updatedHTML = [NSString
                             stringWithFormat:@"<body bgcolor=\"grey\"><font color=\"white\">%@</font></body>", updateHTML];
    
    [[self view]setBackgroundColor:[cp tint_background]];
    
    [self openHTML:updatedHTML];

}

#pragma mark - Action Handlers

// Handles toggling of saved button
- (IBAction)button_SavePage:(id)sender {
    savedButtonState = !savedButtonState;
    if (savedButtonState) {
        [button_savePage setImage:[UIImage imageNamed:@"toolbar_Save_Clicked"]];
        // Here, the Page obj should be added to the cell array.
        if (url != nil) {
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"MMM dd, yyyy HH:mm"];
            NSDate *now = [[NSDate alloc] init];
            NSString *dateString = [format stringFromDate:now];
            Notebook *notebook = [[Notebook alloc] init];
        
            Page *newPage = [[Page alloc] initWithURL:url withHTML:htmlContent withDateSaved:dateString withNoteBook:notebook];
            [newPage savePage:newPage];
        }
    
    } else {
        [button_savePage setImage:[UIImage imageNamed:@"toolbar_Save_Unclicked"]];
        // Here, the Page obj should be removed from the cell array.
    
    
    }
}

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

// Toggle saving of the Page Object
- (IBAction)button_savePageWasPressed:(id)sender {
    savedButtonState = !savedButtonState;
    if (savedButtonState) {
        [button_savePage setImage:[UIImage imageNamed:@"toolbar_Save_Clicked"]];
        // Here, the Page obj should be ADDED to the cell array.
    } else {
        [button_savePage setImage:[UIImage imageNamed:@"toolbar_Save_Unclicked"]];
        // Here, the Page obj should be REMOVED from the cell array.
    }
}

// Present the Auto Scroll View Controller
- (IBAction)button_autoScrollWasPressed:(id)sender {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard
                                storyboardWithName:storyboardName
                                bundle:[NSBundle bundleForClass:[self class]]];
    
    AutoScrollViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"AutoScrollViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
}

// Handle sharing of Page Object and Notebook Object, depending on settings.
// Should also present an option to view the full page normally.
- (IBAction)button_actionWasPressed :(id)sender {
    #warning incomplete implementation
}

// Switch to expanded settings state
- (IBAction)button_defaultSettingsWasPressed:(id)sender {
    [self.navigationController.toolbar setItems:array_settingsToolbarButtons animated:YES];
}

// Present the Settings View Controller
- (IBAction)button_moreWasPressed:(id)sender {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard
                                storyboardWithName:storyboardName
                                bundle:[NSBundle bundleForClass:[self class]]];
    
    SettingsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
}

// Toggle Night Mode
- (IBAction)button_nightModeWasPressed:(id)sender {
    nightModeState = !nightModeState;
    if (nightModeState) {
        [cp changeColorProfile:@"NightMode"];
        [button_nightMode setImage:[UIImage imageNamed:@"settingsToolbar_NightMode_Unclicked"]];
        [self updateColorScheme];
    } else {
        [cp changeColorProfile:@"Default"];
        [button_nightMode setImage:[UIImage imageNamed:@"settingsToolbar_NightMode_Clicked"]];
        [self updateColorScheme];
    }
}

// Change Toolbar to slider and adjust the text size based on Slider value.
- (IBAction)button_textSizeWasPressed:(id)sender {
    [self.slider_textSize setHidden:NO];
    
    UIBarButtonItem *slider_ConvertedForBarButton = [[UIBarButtonItem alloc] initWithCustomView:slider_textSize];
    NSArray *array_SliderInterface = @[slider_ConvertedForBarButton, flexibleSpace, button_done];
    
    [self.navigationController.toolbar setItems:array_SliderInterface animated:YES];
}

// Switch back to normal state
- (IBAction)button_expandedSettingsWasPressed:(id)sender {
    [self.navigationController.toolbar setItems:array_defaultToolbarButtons animated:YES];
}

#pragma mark - Supporting Methods

// Action for "Done Button" in "textSizeWasPressed" method
- (IBAction)button_doneWasPressed:(id)sender {
    [userSettings setTextSize:slider_textSize.value];
    [self.navigationController.toolbar setItems:array_defaultToolbarButtons animated:YES];
}

// Action Method for Text Size slider
- (IBAction)slider_textSizeValueChanged:(id)sender {
    [userSettings setTextSize:slider_textSize.value];
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

#pragma mark - UIWebView Handlers

- (void)openHTML:(NSString *)html {
    //Loads UIWebView with HTML
    [webView loadHTMLString:html baseURL:nil];
}

- (void)highlight_yellow {
    
    const CGFloat *components = CGColorGetComponents([UIColor yellowColor].CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    NSString *hexString=[NSString stringWithFormat:@"%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
    
    highlightColor = hexString;
    
    if (!pageHtml) {
        pageHtml = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
    }
    
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSString *insertSpan = [NSString stringWithFormat:@"var range = window.getSelection().getRangeAt(0);var selectionContents   = range.extractContents(); var span = document.createElement(\"span\"); span.appendChild(selectionContents); span.setAttribute(\"class\",\"uiWebviewHighlight\"); span.style.backgroundColor  = \"#%@\"; span.setAttribute(\"id\", \"%@\");range.insertNode(span);",highlightColor, uuid];
    
    [webView stringByEvaluatingJavaScriptFromString:insertSpan];
    
    savedHtml = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].innerHTML"];
    
}

- (void)highlight_red {
    
    // USE THIS FOR ALL OF THE OTHER HIGHLIGHTING METHODS
    const CGFloat *components = CGColorGetComponents([UIColor redColor].CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    NSString *hexString=[NSString stringWithFormat:@"%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
    
    highlightColor = hexString;
    
    
    if (!pageHtml) {
        pageHtml = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
    }
    
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSString *insertSpan = [NSString stringWithFormat:@"var range = window.getSelection().getRangeAt(0);var selectionContents   = range.extractContents(); var span = document.createElement(\"span\"); span.appendChild(selectionContents); span.setAttribute(\"class\",\"uiWebviewHighlight\"); span.style.backgroundColor  = \"#%@\"; span.setAttribute(\"id\", \"%@\");range.insertNode(span);",highlightColor, uuid];
    
    [webView stringByEvaluatingJavaScriptFromString:insertSpan];
    
    savedHtml = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].innerHTML"];
    
}

- (void)highlight_blue {
    
    const CGFloat *components = CGColorGetComponents([UIColor blueColor].CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    NSString *hexString=[NSString stringWithFormat:@"%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
    
    highlightColor = hexString;
    
    if (!pageHtml) {
        pageHtml = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
    }
    
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSString *insertSpan = [NSString stringWithFormat:@"var range = window.getSelection().getRangeAt(0);var selectionContents   = range.extractContents(); var span = document.createElement(\"span\"); span.appendChild(selectionContents); span.setAttribute(\"class\",\"uiWebviewHighlight\"); span.style.backgroundColor  = \"#%@\"; span.setAttribute(\"id\", \"%@\");range.insertNode(span);",highlightColor, uuid];
    
    [webView stringByEvaluatingJavaScriptFromString:insertSpan];
    
    savedHtml = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].innerHTML"];
    
}

- (void)highlight_orange {
    
    const CGFloat *components = CGColorGetComponents([UIColor orangeColor].CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    NSString *hexString=[NSString stringWithFormat:@"%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
    
    highlightColor = hexString;
    if (!pageHtml) {
        pageHtml = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
    }
    
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSString *insertSpan = [NSString stringWithFormat:@"var range = window.getSelection().getRangeAt(0);var selectionContents   = range.extractContents(); var span = document.createElement(\"span\"); span.appendChild(selectionContents); span.setAttribute(\"class\",\"uiWebviewHighlight\"); span.style.backgroundColor  = \"#%@\"; span.setAttribute(\"id\", \"%@\");range.insertNode(span);",highlightColor, uuid];
    
    [webView stringByEvaluatingJavaScriptFromString:insertSpan];
    
    savedHtml = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].innerHTML"];
    
}

- (NSString *)hexStringForColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    NSString *hexString=[NSString stringWithFormat:@"%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
    return hexString;
}

@end
