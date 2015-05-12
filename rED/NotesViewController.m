//
//  NotesViewController.m
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "NotesViewController.h"
#import "PagesViewController.h"
#import "NotebookManagerTableViewController.h"
#import "EditSectionViewController.h"
#import "ColorPalette.h"
#import "Settings.h"
#import "Section.h"
#import "Notebook.h"

@interface NotesViewController ()
{
    ColorPalette *cp;
    Settings *sharedSettings;
    Notebook *sharedNotebook;
}
@end

@implementation NotesViewController
@synthesize textView, button_quotations, button_sections, button_share, loadedSection;

#pragma mark - Initializers

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        cp = [[ColorPalette alloc] init];
        sharedSettings = [Settings sharedSettings];
        sharedNotebook = [Notebook sharedNotebook];
    }
    return self;
}

#pragma mark - View Handlers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initial Section Loading
    NSUInteger sectionID = [sharedNotebook indexOfLastLoadedSection];
    [self loadSection:sectionID];
    
    // Swipe Declaration
    UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(gesture_SwipeRight:)];
    
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    // Navigation Bar Configuration
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    // Toolbar Configuration
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController.toolbar setBarTintColor:[cp tint_background]];
}

- (void)viewWillAppear:(BOOL)animated {
    
    // Toolbar Configuration
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController setToolbarHidden:YES];
    
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
    [label_section setFont:titleFont];
    [label_section setTextColor:[UIColor darkTextColor]];
    [label_section sizeToFit];
    
    UIBarButtonItem *label_sectionBBI = [[UIBarButtonItem alloc] initWithCustomView:label_section];
    [self.navigationItem setRightBarButtonItem:label_sectionBBI];
}

// Saves the changes to the Notebook upon dismissal
- (void)viewWillDisappear:(BOOL)animated {
    [self saveSectionChanges];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// Allows user to exit editing
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

-(void)updateColorScheme {}

#pragma mark - Gesture Recognizers

// Switch to Home
- (void)gesture_SwipeRight:(UISwipeGestureRecognizer*)gestureRecognizer {
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

// Used for sharing the current section
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Section Handlers

// Loads a section at the given index for the section in array_sections
- (void)loadSection:(NSUInteger)sectionAtIndex {
    NSLog(@"Accessing Section at index: %lu", (unsigned long)sectionAtIndex);
    
    Section *sectionForLoad = [sharedNotebook.array_sections objectAtIndex:sectionAtIndex];
    
    loadedSection = sectionForLoad;
    sharedNotebook.indexOfLastLoadedSection = loadedSection.indexInArray;
    loadedSection.isLastLoadedSection = YES;
    
    NSLog(@"Loaded Section: %@", loadedSection.title);
    textView.text = loadedSection.textContent;
    
    [self viewWillAppear:YES];
}

// Parallels the mutated loadedSection to its older version in array_sections
- (void)saveSectionChanges {
    NSUInteger indexOfSection = loadedSection.indexInArray;
    NSLog(@"Saving Section: %@ at index: %lu", loadedSection.title, (unsigned long)indexOfSection);
    
    loadedSection.textContent = textView.text;
    [sharedNotebook.array_sections replaceObjectAtIndex:indexOfSection withObject:loadedSection];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segue_toNotebookManager"]) {
        NotebookManagerTableViewController *vc = [segue destinationViewController];
        vc.referenceToNotesViewController = self;
    }
    
    if ([[segue identifier] isEqualToString:@"segue_toEditSection"]) {
        EditSectionViewController *vc2 = [segue destinationViewController];
        vc2.indexOfSectionForEdit = loadedSection.indexInArray;
    }
}

@end
