//
//  NotebookManagerTableViewController.m
//  rED
//
//  Created by Cole Smith on 2/21/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "NotebookManagerTableViewController.h"
#import "AddSectionViewController.h"
#import "NotesViewController.h"
#import "SectionTableViewCell.h"
#import "ColorPalette.h"
#import "Notebook.h"
#import "Section.h"

@interface NotebookManagerTableViewController ()
{
    ColorPalette *cp;
    Notebook *sharedNotebook;
    Section *sectionAtIndexPath;
    
    AddSectionViewController *addSectionVC;
}

@end

@implementation NotebookManagerTableViewController
@synthesize referenceToNotesViewController, presentingTableView;

#pragma mark - Initializers

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        cp = [[ColorPalette alloc] init];
        sharedNotebook = [Notebook sharedNotebook];
        
        // Branching View Controller Initializations
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard
                                    storyboardWithName:storyboardName
                                    bundle:[NSBundle bundleForClass:[self class]]];
        
        addSectionVC = [storyboard instantiateViewControllerWithIdentifier:@"AddSectionViewController"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Implements custom title with formatting
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *naviTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    UIFont *titleFont = [UIFont fontWithName:@"Bodoni 72 Oldstyle" size:20.0];
    [naviTitle setText:@"Notebook Tabs"];
    [naviTitle setFont:titleFont];
    [naviTitle setTextColor:[cp tint_text]];
    [naviTitle sizeToFit];
    self.navigationItem.titleView = naviTitle;
    
    // Add Section Button
    UIBarButtonItem *button_add = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                   target:self
                                   action:@selector(button_addWasPressed:)];
    self.navigationItem.rightBarButtonItem = button_add;
}

- (void)viewWillAppear:(BOOL)animated {
    [presentingTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)updateColorScheme {}

#pragma mark - Action Handlers

// Present the Add Section View Controller
- (IBAction)button_addWasPressed:(id)sender {
    [[self navigationController] pushViewController:addSectionVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return sharedNotebook.array_sections.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_Section"];
    
    sectionAtIndexPath = [sharedNotebook.array_sections objectAtIndex:indexPath.row];
    NSString *sectionTitle = sectionAtIndexPath.title;
    UIColor *sectionColor = sectionAtIndexPath.color;
    
    cell.label_sectionTitle.text = sectionTitle;
    cell.label_sectionColor.backgroundColor= sectionColor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [referenceToNotesViewController loadSection:sectionAtIndexPath.indexInArray];
    [self.navigationController popViewControllerAnimated:YES];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Do not allow last section to be deleted.
    if (sharedNotebook.array_sections.count < 2) {
        return NO;
    } else {
        return YES;
    }
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Section Deletion"
                                    message:@"This Section will be deleted from your Notebook. This cannot be reversed."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *delete = [UIAlertAction
                                 actionWithTitle:@"Delete"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action) {
                                     
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                     NSUInteger indexForDelete = indexPath.row;
                                     Section *sectionForDelete = [sharedNotebook.array_sections objectAtIndex:indexForDelete];
                                     [sharedNotebook removeSection:sectionForDelete];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
