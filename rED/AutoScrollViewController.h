//
//  AutoScrollViewController.h
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

/*
 The Auto-Scroll behavior should be as follows:
    The Pan Gesture Recognizer will change the scrolling speed
        UP for slower
        DOWN for Faster
    The Tap Gesture Recognizer will pause / play the scrolling
        DOUBLE TAP will stop scrolling
        Stopping the scroll will allow the user to scroll manually as usual
        DOUBLE TAP to start auto scroll again
 */

#import <UIKit/UIKit.h>

@interface AutoScrollViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *button_Done;

- (IBAction)button_DoneWasPressed:(id)sender;

@end
