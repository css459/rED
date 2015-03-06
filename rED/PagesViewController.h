//
//  PagesViewController.h
//  rED
//
//  Created by Cole Smith on 2/3/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"

@interface PagesViewController : UIViewController <UISearchBarDelegate>

// Web Viewing Properties
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

// HTML Properties
@property (weak, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *htmlContent;
@property (strong, nonatomic) NSString *updateHTML;
@property (weak, nonatomic) NSDictionary *htmlDictionary;

// Supporting Properties
@property (strong, nonatomic) UISlider *slider_textSize;

// Button Actions
- (IBAction)button_savePageWasPressed:(id)sender;
- (IBAction)button_autoScrollWasPressed:(id)sender;
- (IBAction)button_actionWasPressed :(id)sender;
- (IBAction)button_defaultSettingsWasPressed:(id)sender;
- (IBAction)button_moreWasPressed:(id)sender;
- (IBAction)button_nightModeWasPressed:(id)sender;
- (IBAction)button_textSizeWasPressed:(id)sender;
- (IBAction)button_expandedSettingsWasPressed:(id)sender;

// Supporting Actions
- (IBAction)button_doneWasPressed:(id)sender;
- (IBAction)slider_textSizeValueChanged:(id)sender;

// Gesture Handlers
- (void)gesture_SwipeLeft:(UISwipeGestureRecognizer*)gestureRecognizer;
- (void)gesture_SwipeRight:(UISwipeGestureRecognizer*)gestureRecognizer;

// HTML Handlers
- (void)searchBarSearchButtonClicked:(UISearchBar *)sB;
- (void)getHTML:(NSString *)URL;
- (void)openHTML:(NSString *)html;

@end

