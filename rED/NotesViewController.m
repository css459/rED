//
//  NotesViewController.m
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "NotesViewController.h"
#import "PagesViewController.h"
#import "ColorPalette.h"
#import "Settings.h"
#import "Section.h"
#import "Notebook.h"

@interface NotesViewController ()

@end

@implementation NotesViewController
{
    ColorPalette *cp;
    Settings *sharedSettings;
    Notebook *sharedNotebook;
}

@synthesize textView, button_quotations, button_sections, button_share, loadedSection;

#pragma mark - Initializers

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        cp = [[ColorPalette alloc] init];
        sharedSettings = [Settings sharedSettings];
        sharedNotebook = [Notebook sharedNotebook];
        [self loadSection:[sharedNotebook lastLoadedSection]];
    }
    return self;
}

#pragma mark - View Handlers

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    
    // Implements custom title with formatting
    UIFont *titleFont = [UIFont fontWithName:@"Bodoni 72 Oldstyle" size:20.0];
    UILabel *label_notebook = [[UILabel alloc] initWithFrame:CGRectZero];
    UILabel *label_section = [[UILabel alloc] initWithFrame:CGRectZero];
    
    [label_notebook setText:@"Notebook"];
    [label_notebook setFont:titleFont];
    [label_notebook setTextColor:[UIColor darkTextColor]];
    [label_notebook sizeToFit];
    
    UIBarButtonItem *label_notebookBBI = [[UIBarButtonItem alloc] initWithCustomView:label_notebook];
    [self.navigationItem setLeftBarButtonItem:label_notebookBBI];

    [label_section setText:@"Section"];     // This should be dynamic
    [label_section setText:loadedSection];
    [label_section setFont:titleFont];
    [label_section setTextColor:[UIColor darkTextColor]];
    [label_section sizeToFit];
    
    UIBarButtonItem *label_sectionBBI = [[UIBarButtonItem alloc] initWithCustomView:label_section];
    [self.navigationItem setRightBarButtonItem:label_sectionBBI];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    // Swipe Declaration
    UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(gesture_SwipeRight:)];
    
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    // Toolbar Configuration
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController.toolbar setBarTintColor:[cp tint_background]];
    
    CGRect headerTitleSubtitleFrame = CGRectMake(0, 0, 200, 44);
    UIView* _headerTitleSubtitleView = [[UILabel alloc] initWithFrame:headerTitleSubtitleFrame];
    _headerTitleSubtitleView.backgroundColor = [UIColor clearColor];
    _headerTitleSubtitleView.autoresizesSubviews = YES;
    
    CGRect titleFrame = CGRectMake(0, 2, 200, 24);
    titleView = [[UILabel alloc] initWithFrame:titleFrame];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont systemFontOfSize:20];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.textColor = [UIColor blackColor];
    titleView.shadowColor = [UIColor darkGrayColor];
    titleView.shadowOffset = CGSizeMake(0, -1);
    titleView.text = @"TITLE";
    titleView.adjustsFontSizeToFitWidth = YES;
    [_headerTitleSubtitleView addSubview:titleView];
    
    CGRect subtitleFrame = CGRectMake(0, 24, 200, 44-24);
    subtitleView = [[UILabel alloc] initWithFrame:subtitleFrame];
    subtitleView.backgroundColor = [UIColor clearColor];
    subtitleView.font = [UIFont systemFontOfSize:13];
    subtitleView.textAlignment = NSTextAlignmentCenter;
    subtitleView.textColor = [UIColor blackColor];
    subtitleView.shadowColor = [UIColor darkGrayColor];
    subtitleView.shadowOffset = CGSizeMake(0, -1);
    subtitleView.text = @"SUBTITLE";
    subtitleView.adjustsFontSizeToFitWidth = YES;
    [_headerTitleSubtitleView addSubview:subtitleView];
    
    _headerTitleSubtitleView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                                 UIViewAutoresizingFlexibleRightMargin |
                                                 UIViewAutoresizingFlexibleTopMargin |
                                                 UIViewAutoresizingFlexibleBottomMargin);
    
    self.navigationItem.titleView = _headerTitleSubtitleView;
}

-(void) setHeaderTitle:(NSString*)headerTitle andSubtitle:(NSString*)headerSubtitle {
    assert(self.navigationItem.titleView != nil);
    UIView* headerTitleSubtitleView = self.navigationItem.titleView;
    titleView = [headerTitleSubtitleView.subviews objectAtIndex:0];
    subtitleView = [headerTitleSubtitleView.subviews objectAtIndex:1];
    assert((titleView != nil) && (subtitleView != nil) && ([titleView isKindOfClass:[UILabel class]]) && ([subtitleView isKindOfClass:[UILabel class]]));
    titleView.text = headerTitle;
    subtitleView.text = headerSubtitle;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self adjustLabelsForOrientation:toInterfaceOrientation];
}

- (void) adjustLabelsForOrientation:(UIInterfaceOrientation)orientation {
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        titleView.font = [UIFont boldSystemFontOfSize:16];
        subtitleView.font = [UIFont boldSystemFontOfSize:11];
    }
    else if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        titleView.font = [UIFont boldSystemFontOfSize:20];
        subtitleView.font = [UIFont boldSystemFontOfSize:13];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)updateColorScheme {}

#pragma mark - Gesture Recognizers

// Switch to Home
- (void)gesture_SwipeRight:(UISwipeGestureRecognizer*)gestureRecognizer {
//    NSString * storyboardName = @"Main";
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle bundleForClass:[self class]]];
//    PagesViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"PagesViewController"];
//    [[self navigationController] pushViewController:vc animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Action Handlers

// Open up mail view controller with text
- (IBAction)button_ShareWasPressed:(id)sender {
    NSString *emailText = [textView text];
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        
        [mailViewController setSubject:@"My Note"];
        
        [mailViewController setMessageBody:emailText isHTML:NO];
        
        [self presentViewController:mailViewController animated:YES completion:nil];
    }
}

// Sections View Controller called via Storyboard segue
- (IBAction)button_sectionsWasPressed:(id)sender {}

// Quotations View Controller called via Storyboard segue
- (IBAction)button_quotationsWasPressed:(id)sender {}

#pragma mark - Supporting Actions

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#warning incomplete method implementation
- (void)loadSection:(Section *)section {
    loadedSection = section;
    NSLog(@"Loaded Section: %@", loadedSection.title);
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
