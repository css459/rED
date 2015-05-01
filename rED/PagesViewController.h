//
//  PagesViewController.h
//  rED
//
//  Created by Cole Smith on 2/3/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Settings.h"

@interface PagesViewController : UIViewController <UISearchBarDelegate, MFMailComposeViewControllerDelegate>

// Web Viewing Properties
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

// HTML Properties
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *htmlContent;
@property (strong, nonatomic) NSString *updateHTML;
@property (weak, nonatomic) NSDictionary *htmlDictionary;

// Supporting Properties
@property (strong, nonatomic) UISlider *slider_textSize;
@property (strong, nonatomic) NSString *highlightColor;
@property (strong, nonatomic) NSString *pageHtml;
@property (strong, nonatomic) NSString *savedHtml;
@property (nonatomic) UIBarButtonItem *button_done;

// Button Actions
- (IBAction)button_savePageWasPressed:(id)sender;
- (IBAction)button_autoScrollWasPressed:(id)sender;
- (IBAction)button_actionWasPressed :(id)sender;
- (IBAction)button_defaultSettingsWasPressed:(id)sender;
- (IBAction)button_moreWasPressed:(id)sender;
- (IBAction)button_nightModeWasPressed:(id)sender;
- (IBAction)button_textSizeWasPressed:(id)sender;
- (IBAction)button_expandedSettingsWasPressed:(id)sender;

// Supporting Methods
- (IBAction)button_doneWasPressed:(id)sender;
- (IBAction)slider_textSizeValueChanged:(id)sender;
- (void)checkForSavingInconsistencies;
- (void)resetViewForCurrentPage;
- (void)loadPage:(Page *)pageToLoad;

// Gesture Handlers
- (void)gesture_SwipeLeft:(UISwipeGestureRecognizer*)gestureRecognizer;
- (void)gesture_SwipeRight:(UISwipeGestureRecognizer*)gestureRecognizer;

// HTML Handlers
- (void)searchBarSearchButtonClicked:(UISearchBar *)sB;
- (void)getHTML:(NSString *)URL;
- (void)openHTML:(NSString *)html;

// Highlighting Methods
- (void)highlight_red;
- (void)highlight_yellow;
- (void)highlight_blue;
- (void)highlight_orange;

@end
