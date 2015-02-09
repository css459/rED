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
    UIColor *default_accent;     // Prev. tint_master_red
    UIColor *default_text;
    UIColor *default_background;
    
    UIColor *nightMode_accent;
    UIColor *nightMode_text;
    UIColor *nightMode_background;
}
@end

@implementation ColorPalette
@synthesize tint_accent, tint_background, tint_text;

- (id)init {
    
    // Default Mode implementation
    default_background = [UIColor whiteColor];
    default_text = [UIColor darkTextColor];
    default_accent = [[UIColor alloc] initWithRed:187.0/255 green:28.0/255 blue:29.0/255 alpha:1.0];
    
    // Night Mode implementation
    nightMode_background = [UIColor darkGrayColor];
    nightMode_text = [UIColor lightGrayColor];
    nightMode_accent = [[UIColor alloc] initWithRed:0.0/255 green:158.0/255 blue:255.0/255 alpha:1.0];
    
    
    
    tint_background = default_background;
    tint_text = default_text;
    tint_accent = default_accent;
    
    return self;
}

- (void)changeColorProfile:(NSString *)colorProfile {
    if ([colorProfile isEqualToString:@"Default"]) {
        tint_accent = default_accent;
        tint_text = default_text;
        tint_background = default_background;
    }
    else if ([colorProfile isEqualToString:@"NightMode"]) {
        tint_accent = nightMode_accent;
        tint_text = nightMode_text;
        tint_background = nightMode_background;
    }
}
@end
