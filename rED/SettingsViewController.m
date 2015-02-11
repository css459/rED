//
//  SettingsViewController.m
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "SettingsViewController.h"
#import "ColorPalette.h"
#import "Settings.h"

@interface SettingsViewController ()
{
    ColorPalette *cp;
    Settings *userSettings;
}
@end

@implementation SettingsViewController
@synthesize slider_TextSize, label_TextPreview, switch_NightMode, switch_TutorialMode, textField_HomeSite;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        cp = [[ColorPalette alloc] init];
        userSettings = [Settings sharedSettings];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Implements custom title with formatting
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *naviTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    UIFont *titleFont = [UIFont fontWithName:@"Bodoni 72 Oldstyle" size:20.0];
    [naviTitle setText:@"Settings"];
    [naviTitle setFont:titleFont];
    [naviTitle setTextColor:[cp tint_text]];
    [naviTitle sizeToFit];
    self.navigationItem.titleView = naviTitle;
    
    // Color Tints for Night Mode integration
    [self.navigationController.navigationBar setTintColor:[cp tint_text]];
    [self.navigationController.navigationBar setBackgroundColor:[cp tint_background]];
    [self.view setBackgroundColor:[cp tint_background]];
    [self.view setTintColor:[cp tint_accent]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// Allows user to exit editing
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - Setting Components

- (IBAction)slider_TextSizeDidChange:(id)sender {
    double fontSizeAsProportion = slider_TextSize.value;
    
    label_TextPreview.font=[label_TextPreview.font fontWithSize:fontSizeAsProportion];
    [userSettings setTextSize:fontSizeAsProportion];
}

- (IBAction)switch_NightModeDidChange:(id)sender {
    
    if (switch_NightMode.on) {
        [cp changeColorProfile:@"NightMode"];
        [userSettings setNightMode:YES];
    } else {
        [cp changeColorProfile:@"Default"];
        [userSettings setNightMode:NO];
    }
    
    [self.navigationController.navigationBar setTintColor:[cp tint_text]];
    [self.navigationController.navigationBar setBackgroundColor:[cp tint_background]];
    [self.view setBackgroundColor:[cp tint_background]];
    [self.view setTintColor:[cp tint_accent]];

    
}

- (IBAction)switch_TutorialModeDidChange:(id)sender {
    if (switch_TutorialMode.on) {
        [userSettings setTutorialMode:YES];
    } else {
        [userSettings setTutorialMode:NO];
    }
}

- (IBAction)textField_HomeSiteDidChange:(id)sender {
    [userSettings setHomeSite:textField_HomeSite.text];
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
