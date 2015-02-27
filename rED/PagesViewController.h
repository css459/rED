//
//  PagesViewController.h
//  rED
//
//  Created by Cole Smith on 2/3/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagesViewController : UIViewController <UISearchBarDelegate>

// Web Viewing Properties
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

// HTML Properties
@property (weak, nonatomic) NSString *url;
@property (weak, nonatomic) NSString *htmlContent;
@property (weak, nonatomic) NSDictionary *htmlDictionary;

// Button Actions
- (IBAction)button_savePageWasPressed:(id)sender;
- (IBAction)button_autoScrollWasPressed:(id)sender;
- (IBAction)button_actionWasPressed :(id)sender;
- (IBAction)button_defaultSettingsWasPressed:(id)sender;
- (IBAction)button_moreWasPressed:(id)sender;
- (IBAction)button_nightModeWasPressed:(id)sender;
- (IBAction)button_textSizeWasPressed:(id)sender;
- (IBAction)button_expandedSettingsWasPressed:(id)sender;
- (IBAction)button_doneWasPressed:(id)sender;

// Gesture Handlers
- (void)gesture_SwipeLeft:(UISwipeGestureRecognizer*)gestureRecognizer;
- (void)gesture_SwipeRight:(UISwipeGestureRecognizer*)gestureRecognizer;

// HTML Handlers
- (void)searchBarSearchButtonClicked:(UISearchBar *)sB;
- (void)getHTML:(NSString *)URL;
- (void)openHTML:(NSString *)html;

@end

