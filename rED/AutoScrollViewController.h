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
//#import <UIGestureRecognizerDelegate>
@interface AutoScrollViewController : UIViewController



@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property float scrollVal;

@property (nonatomic, strong)NSTimer *timer;

@property int scrollSpeed;

@property (weak, nonatomic) IBOutlet UIToolbar *stopButton;
@property (weak, nonatomic) IBOutlet UIToolbar *fastButton;
@property (weak, nonatomic) IBOutlet UIToolbar *slowButton;
@property (weak, nonatomic) IBOutlet UIToolbar *scrollButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *button_Done;
@property (weak, nonatomic) IBOutlet UIStepper *stepper_ScrollSpeed;

@property int h;

- (IBAction)button_DoneWasPressed:(id)sender;
- (IBAction)stepper_ScrollSpeedDidChange:(id)sender;


-(void)scroll;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event inView:(UIView *)view;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event inView:(UIView *)view;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event inView:(UIView *)view;

-(void)didSwipe:(UISwipeGestureRecognizer*)swipe;

@end



//UIButtonHidden
//  Depending on swiping up or down to change speed
//      Popup tells you what level speed then quickly disappears
