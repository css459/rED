//
//  AutoScrollViewController.m
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

/*
 NOTE:
 
 *The behavior of scroll speed dialing has changed.
 Instead, we will use a gesture of scrolling thumb up in vc to increase
 scroll speed and down to decrease scroll speed.
 
 - This clears up the view and allows the device to be held more naturally without
 reaching for the toolbar
 
 */

#import "AutoScrollViewController.h"

@interface AutoScrollViewController ()

@end

@implementation AutoScrollViewController

@synthesize stepper_ScrollSpeed, scrollVal, scrollSpeed, scrollView, timer, webView, buttonpressed, stopButton, toolBar, HTML;

#pragma mark - Initializers

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {

    }

    scrollVal = 0.0f;
    return self;
}

#pragma mark - View Handlers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    stepper_ScrollSpeed.maximumValue = 4.0;
    stepper_ScrollSpeed.minimumValue = 0.0;
    [stepper_ScrollSpeed setValue:-0.05];
    NSLog(@"before button pressed:%ld",(long)[stepper_ScrollSpeed value]);
    
    [webView loadHTMLString:HTML baseURL:nil];
    
    buttonpressed = NO;
    stepper_ScrollSpeed.userInteractionEnabled = NO;
    [self.navigationController setToolbarHidden:YES];
    
    
}


-(IBAction)stopButtonWasPressed:(id)sender
{
    buttonpressed = !buttonpressed;

    
    if (buttonpressed) {
        //start scrolling
        
        float value = -.1*stepper_ScrollSpeed.value + .5;
        timer = [NSTimer scheduledTimerWithTimeInterval:value target:self selector:@selector(scroll) userInfo:nil repeats:YES];
        
        stepper_ScrollSpeed.userInteractionEnabled = YES;
//        stopButton.style = UIBarButtonSystemItemPause;
//        [stopButton setStyle:UIBarButtonSystemItemPause];
        

        
//        UIBarButtonItem *playButton = [toolBar.items objectAtIndex:2];
        
        UIBarButtonItem *pauseButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(stopButtonWasPressed:)];

        NSMutableArray *array_toolBarObjects = [NSMutableArray arrayWithArray:toolBar.items];
        [array_toolBarObjects replaceObjectAtIndex:2 withObject:pauseButton];
        toolBar.items = array_toolBarObjects;
        
    }else{
        //stop scrolling
        
        
        stepper_ScrollSpeed.userInteractionEnabled = NO;
        [timer invalidate];
        timer = nil;
        
//        UIBarButtonItem *playButton = [toolBar.items objectAtIndex:2];
        UIBarButtonItem *playButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(stopButtonWasPressed:)];

        NSMutableArray *array_toolBarObjects = [NSMutableArray arrayWithArray:toolBar.items];
        [array_toolBarObjects replaceObjectAtIndex:2 withObject:playButton];
        toolBar.items = array_toolBarObjects;
        
        
    }

}

//This will be called every second
-(void)scroll
{
    
    CGPoint bottomOffset = CGPointMake(0, self.webView.scrollView.contentSize.height - self.webView.scrollView.bounds.size.height);
    if (scrollVal < bottomOffset.y) {
        CGPoint scroll = CGPointMake(0, scrollVal);
        scrollVal += 1;
        
        [self.webView.scrollView setContentOffset:scroll animated:YES];
        webView.scrollView.bounces = NO;
        
    } else {
        [timer invalidate];
        timer = nil;
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [timer invalidate];
    timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)updateColorScheme {}

#pragma mark - Action Handlers

// Switch to Home
- (IBAction)button_DoneWasPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// Adjust the scroll speed
- (IBAction)stepper_ScrollSpeedDidChange:(UIStepper *)sender {
    
    float value = -.1*stepper_ScrollSpeed.value + .5;

    [timer invalidate];
    timer = nil;

    timer = [NSTimer scheduledTimerWithTimeInterval:value target:self selector:@selector(scroll) userInfo:nil repeats:YES];

}

- (void)openWebsiteWithAutoscroll:(NSString *)html
{
    HTML = html;
    [self viewDidLoad];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
