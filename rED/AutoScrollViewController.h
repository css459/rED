//
//  AutoScrollViewController.h
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoScrollViewController : UIViewController

// Variable Properties
@property float scrollVal;
@property int scrollSpeed;
@property BOOL buttonpressed;

// Toolbar Buttons
@property (weak, nonatomic) IBOutlet UIBarButtonItem *stopButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *fastButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *slowButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *scrollButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *button_Done;
@property (weak, nonatomic) IBOutlet UIStepper *stepper_ScrollSpeed;

@property (weak, nonatomic) NSArray *bBIArray;

// UI Views
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

// HTML Properties
@property (weak, nonatomic) NSString *HTML;

// Timing Properties
@property (nonatomic, strong)NSTimer *timer;

// Action Handlers
- (IBAction)button_DoneWasPressed:(id)sender;
- (IBAction)stepper_ScrollSpeedDidChange:(id)sender;
- (void)scroll;

// HTML Handlers
- (void)openWebsiteWithAutoscroll:(NSString *)html;

@end
