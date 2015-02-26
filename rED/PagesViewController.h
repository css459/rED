//
//  PagesViewController.h
//  rED
//
//  Created by Cole Smith on 2/3/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagesViewController : UIViewController <UISearchBarDelegate>

// Bar Button Properties
@property (strong, nonatomic) IBOutlet UIBarButtonItem *button_Slot1;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *button_Slot2;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *button_Slot3;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *button_Settings;

// Web Viewing Properties
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

// HTML Properties
@property (weak, nonatomic) NSString *url;
@property (weak, nonatomic) NSString *htmlContent;
@property (weak, nonatomic) NSDictionary *htmlDictionary;

// Gesture Handlers
- (void)gesture_SwipeLeft:(UISwipeGestureRecognizer*)gestureRecognizer;
- (void)gesture_SwipeRight:(UISwipeGestureRecognizer*)gestureRecognizer;

// Button Actions
- (IBAction)button_Slot1WasPressed:(id)sender;
- (IBAction)button_Slot2WasPressed:(id)sender;
- (IBAction)button_Slot3WasPressed:(id)sender;
- (IBAction)button_SettingsWasPressed:(id)sender;

// Custom Transitions
- (void)button_FadeOut:(UIBarButtonItem *)button;

// HTML Handlers
- (void)searchBarSearchButtonClicked:(UISearchBar *)sB;
- (void)getHTML:(NSString *)URL;
- (void)openHTML:(NSString *)html;

@end

