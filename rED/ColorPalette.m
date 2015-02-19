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
@synthesize tint_accent, tint_background, tint_text, tint_navBar, tint_switch_thumb;

- (id)init {
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
    }
    return self;
}

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
