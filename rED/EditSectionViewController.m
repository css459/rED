//
//  EditSectionViewController.m
//  rED
//
//  Created by Cole Smith on 4/29/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "EditSectionViewController.h"
#import "ColorPalette.h"
#import "Section.h"
#import "Notebook.h"

@interface EditSectionViewController ()
{
    ColorPalette *cp;
    Section *sectionForEdit;
    Notebook *sharedNotebook;
}
@end

@implementation EditSectionViewController
@synthesize textField_sectionName, button_changeColor, indexOfSectionForEdit;

#pragma mark - Initializers

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        cp = [[ColorPalette alloc] init];
        sharedNotebook = [Notebook sharedNotebook];
        
        sectionForEdit = [sharedNotebook.array_sections objectAtIndex:indexOfSectionForEdit];
    }
    return self;
}

#pragma mark - View Handlers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Custom title with formatting
    UIFont *titleFont = [UIFont fontWithName:@"Bodoni 72 Oldstyle" size:20.0];
    UILabel *label_title = [[UILabel alloc] initWithFrame:CGRectZero];
    
    [label_title setText:@"Edit Section"];
    [label_title setFont:titleFont];
    [label_title setTextColor:[UIColor darkTextColor]];
    [label_title sizeToFit];
    
    UIBarButtonItem *label_titleBBI = [[UIBarButtonItem alloc] initWithCustomView:label_title];
    [self.navigationItem setRightBarButtonItem:label_titleBBI];
    
    // UI state configurations
    textField_sectionName.text = sectionForEdit.title;
    button_changeColor.tintColor = sectionForEdit.color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// Allows user to exit editing
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

# pragma mark - Action Handlers

- (IBAction)textField_sectionNameDidChange:(id)sender {
    sectionForEdit.title = textField_sectionName.text;
}

- (IBAction)button_changeColorWasPressed:(id)sender {
    [sectionForEdit cycleColors];
    button_changeColor.tintColor = sectionForEdit.color;
}

- (IBAction)button_saveSectionEditsWasPressed:(id)sender {
    [self saveSectionChanges];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Section Handlers

- (void)saveSectionChanges {
    NSLog(@"Saving Section: %@ at index: %lu", sectionForEdit.title, (unsigned long)indexOfSectionForEdit);
    
    sectionForEdit.textContent = textField_sectionName.text;
    sectionForEdit.color = button_changeColor.backgroundColor;
    
    [sharedNotebook.array_sections replaceObjectAtIndex:indexOfSectionForEdit withObject:sectionForEdit];
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
