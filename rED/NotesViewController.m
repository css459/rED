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
        
        int sectionID = [sharedNotebook indexOfLastLoadedSection];
        [self loadSection:sectionID];
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

    [label_section setText:loadedSection.title];
    [label_section setText:loadedSection.title];
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
}

- (void)viewWillDisappear:(BOOL)animated {
    [self saveSectionChanges];
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

#pragma mark - Section Handlers

- (void)loadSection:(NSUInteger)sectionAtIndex {
    Section *sectionForLoad = [sharedNotebook.array_sections objectAtIndex:sectionAtIndex];
    loadedSection = sectionForLoad;
    NSLog(@"Loaded Section: %@", loadedSection.title);
    textView.text = loadedSection.textContent;
}

- (void)saveSectionChanges {
    [sharedNotebook.array_sections replaceObjectAtIndex:loadedSection.indexInArray withObject:loadedSection];
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
