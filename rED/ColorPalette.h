//
//  ColorPalette.h
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

/*
 This class handles the consistency of colors across the application.
 Colors are simply defined as UIColor properties as called using the getter for that object.
 
 The property names should be fairly explanatory for their purposes but for clarity:
 
    * tint_accent: used for buttons and elements that require a color that "pops"
    * tint_text: used for all text everywhere
    * tint_background: used for the background of the view controller and sometimes labels or fields
      where required
    * tint_switch_thumb: used exclusively for the tops of UISwitches
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorPalette : NSObject

@property (nonatomic) UIColor *tint_accent;
@property (nonatomic) UIColor *tint_text;
@property (nonatomic) UIColor *tint_background;
@property (nonatomic) UIColor *tint_navBar;
@property (nonatomic) UIColor *tint_switch_thumb;

@property (nonatomic) const UIColor *highlight_yellow;
@property (nonatomic) const UIColor *highlight_red;
@property (nonatomic) const UIColor *highlight_blue;
@property (nonatomic) const UIColor *highlight_orange;

- (void)changeColorProfile: (NSString *) colorProfile;

@end
