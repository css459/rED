//
//  NotesViewController.m
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "NotesViewController.h"
#import "PagesViewController.h"

@interface NotesViewController ()

@end

@implementation NotesViewController

@synthesize textView;

#pragma mark - Initializers

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

#pragma mark - View Handlers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Implements custom title with formatting
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *naviTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    UIFont *titleFont = [UIFont fontWithName:@"Bodoni 72 Oldstyle" size:20.0];
    [naviTitle setText:@"Notebook"];
    [naviTitle setFont:titleFont];
    [naviTitle setTextColor:[UIColor darkTextColor]];
    [naviTitle sizeToFit];
    self.navigationItem.titleView = naviTitle;
    [self.navigationController.navigationBar setBarTintColor: [UIColor whiteColor]];
    self.navigationItem.hidesBackButton = YES;
    
    // Bar Buttons
    UIBarButtonItem *button_Share = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                     target:self
                                     action:@selector(button_ShareWasPressed:)];
    [self.navigationItem setRightBarButtonItem:button_Share];
    
    // Swipe Declaration
    UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(gesture_SwipeRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action Handlers

// Switch to Home
- (void)gesture_SwipeRight:(UISwipeGestureRecognizer*)gestureRecognizer {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle bundleForClass:[self class]]];
    PagesViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"PagesViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
}

// Open up mail view controller with text
- (IBAction)button_ShareWasPressed:(id)sender
{
    NSString *emailText = [textView text];
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        
        [mailViewController setSubject:@"My Note"];
        
        [mailViewController setMessageBody:emailText isHTML:NO];
        
        [self presentViewController:mailViewController animated:YES completion:nil];
    }

}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
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
