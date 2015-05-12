//
//  AddSectionViewController.m
//  rED
//
//  Created by Cole Smith on 4/25/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "AddSectionViewController.h"
#import "ColorPalette.h"
#import "Section.h"
#import "Notebook.h"

@interface AddSectionViewController ()
{
    ColorPalette *cp;
    Section *newSection;
    Notebook *sharedNotebook;
}
@end

@implementation AddSectionViewController
@synthesize textField_sectionName, button_changeColor;

#pragma mark - Initializers

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        cp = [[ColorPalette alloc] init];
        newSection = [[Section alloc] init];
        sharedNotebook = [Notebook sharedNotebook];
    }
    return self;
}

#pragma mark - View Handlers

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIFont *titleFont = [UIFont fontWithName:@"Bodoni 72 Oldstyle" size:20.0];
    UILabel *label_title = [[UILabel alloc] initWithFrame:CGRectZero];
    
    [label_title setText:@"New Section"];
    [label_title setFont:titleFont];
    [label_title setTextColor:[UIColor darkTextColor]];
    [label_title sizeToFit];

    UIBarButtonItem *label_titleBBI = [[UIBarButtonItem alloc] initWithCustomView:label_title];
    [self.navigationItem setRightBarButtonItem:label_titleBBI];
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
    newSection.title = textField_sectionName.text;
}

- (IBAction)button_changeColorWasPressed:(id)sender {
    [newSection cycleColors];
    button_changeColor.tintColor = newSection.color;
}

- (IBAction)button_saveNewSectionWasPressed:(id)sender {
    [sharedNotebook saveSection:newSection];
    [self.navigationController popViewControllerAnimated:YES];
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
