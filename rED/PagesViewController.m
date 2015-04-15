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
#import "UIMenuItem+CXAImageSupport.h"

@interface PagesViewController ()
{
    // States
    BOOL savedButtonState;
    BOOL nightModeState;
    
    // Slider Variables
    double previousSize;
    
    // Utility Objects
    ColorPalette *cp;
    Settings *userSettings;
    
    
    // View Controller Instances
    SavedPagesTableViewController *savedPagesVC;
    NotesViewController *notesVC;
    
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
        
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard
                                    storyboardWithName:storyboardName
                                    bundle:[NSBundle bundleForClass:[self class]]];
        
        savedPagesVC = [storyboard instantiateViewControllerWithIdentifier:@"SavedPagesTableViewController"];
        notesVC = [storyboard instantiateViewControllerWithIdentifier:@"NotesViewController"];
        
        
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

        array_settingsToolbarButtons = @[button_more, flexibleSpace, button_textSize, flexibleSpace, button_expandedSettings];

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
    
    UIImage *redIcon = [UIImage imageNamed: @"highlight_Red"];
    UIImage *yellowIcon = [UIImage imageNamed: @"highlight_Yellow"];
    UIImage *blueIcon = [UIImage imageNamed: @"highlight_Blue"];
    UIImage *orangeIcon = [UIImage imageNamed: @"highlight_Orange"];
    
    UIMenuItem *highlightRedItem = [[UIMenuItem alloc]
                                    initWithTitle:NSLocalizedString(@"Red Highlight", nil)
                                    action:@selector(highlight_red)];
    
    UIMenuItem *highlightYellowItem = [[UIMenuItem alloc]
                                       initWithTitle:NSLocalizedString(@"Yellow Highlight", nil)
                                       action:@selector(highlight_yellow)];
    
    UIMenuItem *highlightBlueItem = [[UIMenuItem alloc]
                                     initWithTitle:NSLocalizedString(@"Blue Highlight", nil)
                                     action:@selector(highlight_blue)];
    
    UIMenuItem *highlightOrangeItem = [[UIMenuItem alloc]
                                       initWithTitle:NSLocalizedString(@"Orange Highlight", nil)
                                       action:@selector(highlight_orange)];
    
    [highlightRedItem cxa_initWithTitle:@"Red Highlight" action:@selector(highlight_red) image:redIcon];
    [highlightYellowItem cxa_initWithTitle:@"Yellow Highlight" action:@selector(highlight_yellow) image:yellowIcon];
    [highlightBlueItem cxa_initWithTitle:@"Blue Highlight" action:@selector(highlight_blue) image:blueIcon];
    [highlightOrangeItem cxa_initWithTitle:@"Orange Highlight" action:@selector(highlight_orange) image:orangeIcon];
    
    [UIMenuController sharedMenuController].menuItems = @[highlightRedItem, highlightYellowItem, highlightBlueItem , highlightOrangeItem];
    
    
    
    
//    - (id)cxa_initWithTitle:(NSString *)title action:(SEL)action image:(UIImage *)image;
//    - (id)cxa_initWithTitle:(NSString *)title action:(SEL)action settings:(CXAMenuItemSettings *)settings;
//    - (void)cxa_setImage:(UIImage *)image;
//    - (void)cxa_setSettings:(CXAMenuItemSettings *)settings;

    
    
}

- (void)viewWillAppear:(BOOL)animated {
    // Hides the Navigation Bar on appearance
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
    // Adjusts text size in UIWebView
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
    
    // Changes UIWebView to night mode
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

// Allows user to exit editing
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

// Switch to Notebook
- (void)gesture_SwipeLeft:(UISwipeGestureRecognizer*)gestureRecognizer {
    [[self navigationController] pushViewController:notesVC animated:YES];
}

// Switch to Saved Pages
- (void)gesture_SwipeRight:(UISwipeGestureRecognizer*)gestureRecognizer {
    [[self navigationController] pushViewController:savedPagesVC animated:YES];
}

#pragma mark - Button Actions

// Toggle saving of the Page Object
- (IBAction)button_savePageWasPressed:(id)sender {
    savedButtonState = !savedButtonState;

    Page *newPage = [[Page alloc] initWithURL:url html:htmlContent];
    
    if (url != nil) {
        if (savedButtonState) {
            
            [button_savePage setImage:[UIImage imageNamed:@"toolbar_Save_Clicked"]];
            [userSettings savePage:newPage];
            
        } else {
            
            // Throw Notification to ask if sure.
            if ([newPage checkForEdits] == NO) {
                UIAlertController *alert = [UIAlertController
                                            alertControllerWithTitle:@"Page Deletion"
                                            message:@"This Page and its Highlights will br removed from Saved Pages. This cannot be reversed."
                                            preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *delete = [UIAlertAction
                                         actionWithTitle:@"Delete"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action) {
                                             
                                             [alert dismissViewControllerAnimated:YES completion:nil];
                                             [userSettings removePage:newPage];
                                             [button_savePage setImage:[UIImage imageNamed:@"toolbar_Save_Unclicked"]];
                                         
                                         }];
                
                UIAlertAction *cancel = [UIAlertAction
                                         actionWithTitle:@"Cancel"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action) {
                                             
                                             [alert dismissViewControllerAnimated:YES completion:nil];
                                             
                                         }];
                
                [alert addAction:delete];
                [alert addAction:cancel];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    } else {
        savedButtonState = NO;
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
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:nil
                                 message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* viewFullPage = [UIAlertAction
                                   actionWithTitle:@"View Full Page"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       // Get the Full page for viewing
                                       [view dismissViewControllerAnimated:YES completion:nil];
                                       
                                       if (url != nil)
                                       {
                                           [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];

                                       }
                                   }];
    
    UIAlertAction* share = [UIAlertAction
                            actionWithTitle:@"Share"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction *action)
                            {
                                // Present Sharing View
                                if (userSettings.sharingMode) {
                                    // Share Page AND Notebook
                                    
                                    if ([MFMailComposeViewController canSendMail]) {
                                        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
                                        mailViewController.mailComposeDelegate = self;
                                        
                                        [mailViewController setSubject:@"Share Page AND Notebook"];
                                        
                                        [mailViewController setMessageBody:@"You have share Page AND Notebook!" isHTML:NO];
                                        
                                        [self presentViewController:mailViewController animated:YES completion:nil];
                                    }
                                    
                                } else {
                                    // Share Page ONLY
                                    
                                    if ([MFMailComposeViewController canSendMail]) {
                                        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
                                        mailViewController.mailComposeDelegate = self;
                                        
                                        [mailViewController setSubject:@"Share Page ONLY"];
                                        
                                        [mailViewController setMessageBody:@"You have share Page ONLY!" isHTML:NO];
                                        
                                        [self presentViewController:mailViewController animated:YES completion:nil];
                                    }
                                }
                                [view dismissViewControllerAnimated:YES completion:nil];
                            }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    [view addAction:viewFullPage];
    [view addAction:share];
    [view addAction:cancel];
    
    [self presentViewController:view animated:YES completion:nil];

}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
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

#pragma mark - Supporting Actions

// Action for "Done Button" in "textSizeWasPressed" method
- (IBAction)button_doneWasPressed:(id)sender {
    [userSettings setTextSize:slider_textSize.value];
    [self.navigationController.toolbar setItems:array_defaultToolbarButtons animated:YES];
}

// Action Method for Text Size slider
- (IBAction)slider_textSizeValueChanged:(id)sender {
    [userSettings setTextSize:slider_textSize.value];
    
    // MAKE THIS INTO A METHOD
    Settings *settings = [Settings sharedSettings];
    if (htmlContent != nil) {
        // Convert settings text size to HTML text size
        double size = [settings textSize];
        if (size >= 1 && size < 11) {
            size = 1;
        }
        if (size >= 11 && size < 21) {
            size = 2;
        }
        if (size >= 21 && size < 31) {
            size = 3;
        }
        if (size >= 31 && size < 41) {
            size = 4;
        }
        if (size >= 41 && size < 51) {
            size = 5;
        }
        if (size >= 51 && size < 61) {
            size = 6;
        }
        if (size >= 61) {
            size = 7;
        }
        
        if (previousSize != size) {
                    
            // Update HTML
            NSString *updatedHTML = [NSString stringWithFormat:@"<font size=\"%f\">%@</font>", size, htmlContent];
            updateHTML = updatedHTML;
            
            // Reload webview html content
            [self openHTML:updateHTML];
            previousSize = size;
            
        }
    }
}

#pragma mark - Highlighting Methods

- (void)highlight_yellow {
    
    const CGFloat *components = CGColorGetComponents([cp highlight_yellow].CGColor);
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
    const CGFloat *components = CGColorGetComponents([cp highlight_red].CGColor);
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
    
    const CGFloat *components = CGColorGetComponents([cp highlight_blue].CGColor);
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
    
    const CGFloat *components = CGColorGetComponents([cp highlight_orange].CGColor);
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
    
    NSLog(@"%@", url);
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
                self.url = [returnedDict objectForKey:@"url"];
                
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


#pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
@end
