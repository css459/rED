//
//  NotesViewController.h
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Section.h"

@interface NotesViewController : UIViewController <MFMailComposeViewControllerDelegate>

// UI Element Properties
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *button_sections;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *button_share;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *button_quotations;
@property (strong, nonatomic) UILabel *titleView;
@property (strong, nonatomic) UILabel *subtitleView;

// Supporting Properties
@property (nonatomic) Section *loadedSection;

// Section Handlers
- (void)loadSection:(NSUInteger)sectionAtIndex;
- (void)saveSectionChanges;

// Gesture Recognizers
- (void)gesture_SwipeRight:(UISwipeGestureRecognizer*)gestureRecognizer;

// Action Handlers
- (IBAction)button_ShareWasPressed:(id)sender;
- (IBAction)button_sectionsWasPressed:(id)sender;
- (IBAction)button_quotationsWasPressed:(id)sender;

@end
