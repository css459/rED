//
//  SettingsViewController.h
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *slider_TextSize;
@property (weak, nonatomic) IBOutlet UILabel *label_TextPreview;
@property (weak, nonatomic) IBOutlet UISwitch *switch_NightMode;
@property (weak, nonatomic) IBOutlet UISwitch *switch_TutorialMode;
@property (weak, nonatomic) IBOutlet UITextField *textField_HomeSite;

- (IBAction)slider_TextSizeDidChange:(id)sender;
- (IBAction)switch_NightModeDidChange:(id)sender;
- (IBAction)textField_HomeSiteDidChange:(id)sender;
- (IBAction)switch_TutorialModeDidChange:(id)sender;

@end
