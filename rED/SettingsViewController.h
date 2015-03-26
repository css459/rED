//
//  SettingsViewController.h
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *label_TutorialMode;
@property (weak, nonatomic) IBOutlet UILabel *label_HomeSite;

@property (weak, nonatomic) IBOutlet UITextView *textView_Disclaimer;
@property (weak, nonatomic) IBOutlet UITextField *textField_HomeSite;

@property (weak, nonatomic) IBOutlet UISwitch *switch_TutorialMode;
@property (weak, nonatomic) IBOutlet UISwitch *switch_SharingMode;

@property (weak, nonatomic) IBOutlet UIButton *button_Info;

@property (weak, nonatomic) NSString *currentURL;

- (IBAction)textField_HomeSiteDidChange:(id)sender;
- (IBAction)switch_TutorialModeDidChange:(id)sender;
- (IBAction)switch_SharingModeDidChange:(id)sender;

@end
