//
//  NotesViewController.h
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface NotesViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (void)gesture_SwipeRight:(UISwipeGestureRecognizer*)gestureRecognizer;
- (IBAction)button_ShareWasPressed:(id)sender;

@end
