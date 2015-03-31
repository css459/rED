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
#import "PagesViewController.h"

@interface SettingsViewController ()
{
    ColorPalette *cp;
    Settings *userSettings;
}
@end

@implementation SettingsViewController
@synthesize switch_TutorialMode, switch_SharingMode, textField_HomeSite, label_HomeSite, label_TutorialMode, textView_Disclaimer, button_Info;

#pragma mark - Initializers

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        cp = [[ColorPalette alloc] init];
        userSettings = [Settings sharedSettings];
    }
    return self;
}

#pragma mark - View Control Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES];
    
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

- (void)viewWillAppear:(BOOL)animated {
    switch_TutorialMode.on = [userSettings tutorialMode];
    textField_HomeSite.text = [userSettings homeSite];
}

- (void)refreshView:(NSNotification *) notification {
    [self viewDidLoad];
    [self viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)updateColorScheme {}

#pragma mark - Action Handlers

- (IBAction)switch_TutorialModeDidChange:(id)sender {
    if (switch_TutorialMode.on) {
        [userSettings setTutorialMode:YES];
    } else {
        [userSettings setTutorialMode:NO];
    }
}

- (IBAction)switch_SharingModeDidChange:(id)sender {
    [userSettings setSharingMode:switch_SharingMode.state];
}

- (IBAction)textField_HomeSiteDidChange:(id)sender {
    [userSettings setHomeSite:textField_HomeSite.text];
}

// Allows user to exit editing
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
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
