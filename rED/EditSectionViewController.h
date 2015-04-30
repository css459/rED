//
//  EditSectionViewController.h
//  rED
//
//  Created by Cole Smith on 4/29/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditSectionViewController : UIViewController

// UI Element Properties
@property (weak, nonatomic) IBOutlet UITextField *textField_sectionName;
@property (weak, nonatomic) IBOutlet UIButton *button_changeColor;
@property (weak, nonatomic) IBOutlet UIButton *button_saveSectionEdits;

// Variable Properties
@property (nonatomic) NSUInteger indexOfSectionForEdit;

// Action Handlers
- (IBAction)textField_sectionNameDidChange:(id)sender;
- (IBAction)button_changeColorWasPressed:(id)sender;
- (IBAction)button_saveSectionEditsWasPressed:(id)sender;

// Section Handlers
- (void)saveSectionChanges;

@end
