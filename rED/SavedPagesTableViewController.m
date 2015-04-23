//
//  SavedPagesTableViewController.m
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "SavedPagesTableViewController.h"
#import "PagesViewController.h"
#import "ColorPalette.h"
#import "Page.h"
#import "Settings.h"
#import "SavedPageTableViewCell.h"

@interface SavedPagesTableViewController ()
{
    ColorPalette *cp;
    Page *navigatingPage;
    Settings *sharedSettings;
    NSUInteger indexForDelete;
}
@end

@implementation SavedPagesTableViewController
@synthesize referenceToRootViewController, presentingTableView;

#pragma mark - Initializers

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        cp = [[ColorPalette alloc] init];
        sharedSettings = [Settings sharedSettings];
    }
    return self;
}

#pragma mark - View Handlers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Implements custom title with formatting
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController setToolbarHidden:YES];
    UILabel *naviTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    UIFont *titleFont = [UIFont fontWithName:@"Bodoni 72 Oldstyle" size:20.0];
    [naviTitle setText:@"Saved Sites"];
    [naviTitle setFont:titleFont];
    [naviTitle setTextColor:[UIColor darkTextColor]];
    [naviTitle sizeToFit];
    self.navigationItem.titleView = naviTitle;
    [self.navigationController.navigationBar setBarTintColor: [UIColor whiteColor]];
    self.navigationItem.hidesBackButton = YES;
    
    // Edit Button
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Swipe Declaration
    UISwipeGestureRecognizer * swipeLeft = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(gesture_SwipeLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController setToolbarHidden:YES];
    NSLog(@"Expected cell count from pages array: %lu", (unsigned long)sharedSettings.array_pages.count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)updateColorScheme {}

#pragma mark - Action Handlers

// Switch to Home
- (void)gesture_SwipeLeft:(UISwipeGestureRecognizer*)gestureRecognizer {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return sharedSettings.array_pages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SavedPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_SavedPage"];
    
    navigatingPage = [sharedSettings.array_pages objectAtIndex:indexPath.row];
    NSString *page_title = navigatingPage.title;
    NSString *page_date = [NSString stringWithFormat:@"Date Captured: %@", [navigatingPage formatDate]];
    NSString *page_htmlContent = navigatingPage.htmlContent;
    
    cell.label_savePage.text = page_title;
    cell.label_dateAdded.text = page_date;
    [cell.webView loadHTMLString:page_htmlContent baseURL:nil];
    
    // Autoscrolling for Cell
    //[cell autoScrollInvocation];
    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Page Deletion"
                                    message:@"This Page and its Highlights will be removed from Saved Pages. This cannot be reversed."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *delete = [UIAlertAction
                                 actionWithTitle:@"Delete"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action) {
                                     
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                     Page *pageForRemoval = [sharedSettings.array_pages objectAtIndex:indexForDelete];
                                     [sharedSettings removePage:pageForRemoval];
                                     
                                     indexForDelete = indexPath.row;
                                     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                     
                                 }];
        
        UIAlertAction *cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action) {
                                     
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
        
        [alert addAction:delete];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Page *pageAtIndexPath = [sharedSettings.array_pages objectAtIndex:indexPath.row];
    [referenceToRootViewController loadPageFromSavedData:pageAtIndexPath];
    [self dismissViewControllerAnimated:YES completion:nil];
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
