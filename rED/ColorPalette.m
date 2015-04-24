//
//  ColorPalette.m
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

/*
    NOTE:
    The ColorPalette will need new methods to change tints to Night Mode
    This will mean a greater degree of consistency in tints will be required.
 */

#import "ColorPalette.h"

@interface ColorPalette ()
{
    UIColor *default_accent;
    UIColor *default_text;
    UIColor *default_background;
    UIColor *default_navBar;
    UIColor *defualt_switch_thumb;
    
    UIColor *nightMode_accent;
    UIColor *nightMode_text;
    UIColor *nightMode_background;
    UIColor *nightMode_navBar;
    UIColor *nightMode_switch_thumb;
    
    UISwitch *modelSwitch;
}
@end

@implementation ColorPalette
@synthesize tint_accent, tint_background, tint_text, tint_navBar, tint_switch_thumb, highlight_blue, highlight_orange, highlight_red, highlight_yellow, array_sectionColors;

- (instancetype)init {
    self = [super init];
    if (self) {
        // Default Mode implementation
        default_background = [UIColor whiteColor];
        default_text = [UIColor darkTextColor];
        default_accent = [[UIColor alloc] initWithRed:187.0/255 green:28.0/255 blue:29.0/255 alpha:1.0];
        default_navBar = [UIColor whiteColor];
        defualt_switch_thumb = [modelSwitch thumbTintColor];
        
        // Night Mode implementation
        nightMode_background = [UIColor darkGrayColor];
        nightMode_text = [UIColor lightTextColor];
        nightMode_accent = [[UIColor alloc] initWithRed:0.0/255 green:158.0/255 blue:255.0/255 alpha:1.0];
        nightMode_navBar = [UIColor blackColor];
        nightMode_switch_thumb = [UIColor lightGrayColor];
        
        // Accessible tint properties
        tint_background = default_background;
        tint_text = default_text;
        tint_accent = default_accent;
        tint_navBar = default_navBar;
        tint_switch_thumb = defualt_switch_thumb;
        
        // Highlights
        highlight_yellow = [UIColor colorWithRed:242.0f/255.0f green:240.0f/255.0f blue:165.0f/255.0f alpha:0.7];
        highlight_blue = [UIColor colorWithRed:201.0f/255.0f green:218.0f/255.0f blue:248.0f/255.0f alpha:0.7];
        highlight_orange = [UIColor colorWithRed:255.0f/255.0f green:198.0f/255.0f blue:112.0f/255.0f alpha:0.7];
        highlight_red = [UIColor colorWithRed:255.0f/255.0f green:124.0f/255.0f blue:124.0f/255.0f alpha:0.7];
        
        // Section Colors 
        array_sectionColors = [[NSArray alloc] init];
        UIColor *pastelRed = [[UIColor alloc] initWithRed:242.0/255.0 green:110.0/255.0 blue:93.0/255.0 alpha:1];
        UIColor *pastelBlue = [[UIColor alloc] initWithRed:123.0/255.0 green:188.0/255.0 blue:231.0/255.0 alpha:1];
        UIColor *pastelGreen = [[UIColor alloc] initWithRed:141.0/255 green:202.0/255 blue:131.0/255 alpha:1];
        UIColor *pastelOrange = [[UIColor alloc] initWithRed:226.0/255 green:181.0/255 blue:89.0/255 alpha:1];
        UIColor *pastelYellow = [[UIColor alloc] initWithRed:233.0/255 green:233.0/255 blue:123.0/255 alpha:1];
        UIColor *pastelPurple = [[UIColor alloc] initWithRed:192.0/255 green:93.0/255 blue:164.0/255 alpha:1];
        UIColor *navyBlue = [[UIColor alloc] initWithRed:44.0/255 green:44.0/255 blue:108.0/255 alpha:1];
        UIColor *deepPurple = [[UIColor alloc] initWithRed:114.0/255 green:42.0/255 blue:95.0/255 alpha:1];
        UIColor *tan = [[UIColor alloc] initWithRed:132.0/255 green:203.0/255 blue:74.0/255 alpha:1];
        UIColor *od = [[UIColor alloc] initWithRed:53.0/255 green:104.0/255 blue:74.0/255 alpha:1];
        
        array_sectionColors = @[pastelRed, pastelBlue, pastelGreen, pastelOrange, pastelPurple,
                                pastelYellow, navyBlue, deepPurple, tan, od];
    }
    return self;
}

#pragma mark - Supporting Methods

- (void)changeColorProfile:(NSString *)colorProfile {
    if ([colorProfile isEqualToString:@"Default"]) {
        tint_accent = default_accent;
        tint_text = default_text;
        tint_background = default_background;
        tint_navBar = default_navBar;
        tint_switch_thumb = defualt_switch_thumb;
    }
    else if ([colorProfile isEqualToString:@"NightMode"]) {
        tint_accent = nightMode_accent;
        tint_text = nightMode_text;
        tint_background = nightMode_background;
        tint_navBar = nightMode_navBar;
        tint_switch_thumb = nightMode_switch_thumb;
    }
}
@end
