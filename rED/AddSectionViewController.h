//
//  AddSectionViewController.h
//  rED
//
//  Created by Cole Smith on 4/25/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSectionViewController : UIViewController

// UI Element Properties
@property (weak, nonatomic) IBOutlet UITextField *textField_sectionName;
@property (weak, nonatomic) IBOutlet UIButton *button_changeColor;
@property (weak, nonatomic) IBOutlet UIButton *button_saveNewSection;

// Action Handlers
- (IBAction)textField_sectionNameDidChange:(id)sender;
- (IBAction)button_changeColorWasPressed:(id)sender;
- (IBAction)button_saveNewSectionWasPressed:(id)sender;

@end
