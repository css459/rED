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
}
@end

@implementation SettingsViewController
@synthesize slider_TextSize, label_TextPreview, switch_NightMode, switch_TutorialMode;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        cp = [[ColorPalette alloc] init];
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// Allows user to exit editing
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

// Handles the font size of reader based on slider value.
- (IBAction)slider_TextSizeDidChange:(id)sender {
    label_TextPreview.font=[label_TextPreview.font fontWithSize:slider_TextSize.value];

    double fontSizeAsProportion = slider_TextSize.value;
    Settings *s = [Settings sharedSettings];
    [s setTextSize:fontSizeAsProportion];
}

#pragma mark - Switches

- (IBAction)switch_NightModeDidChange:(id)sender {
    BOOL switchState = switch_NightMode.state;
    Settings *s = [Settings sharedSettings];
    [s setNightMode:switchState];
    
    if (switchState) {
        NSLog(@"Night Mode ON");
        [cp changeColorProfile:@"NightMode"];
    } else {
        [cp changeColorProfile:@"Default"];
    }
    
}

- (IBAction)switch_TutorialModeDidChange:(id)sender {
    BOOL switchState = switch_TutorialMode.state;
    Settings *s = [Settings sharedSettings];
    [s setNightMode:switchState];
}

- (IBAction)textField_HomeSiteDidChange:(id)sender {
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
