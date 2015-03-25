//
//  ColorPalette.h
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

/* -----------------------------------------------------------------------------
 
    This class handles the consistency of colors thoughout the application.
 
    Section Colors:
 
    Property explanations:
 
        * tint_accent: used for buttons and elements that 
          require a color that "pops"
 
        * tint_text: used for all text everywhere
 
        * tint_background: used for the background of the view controller 
          and sometimes labels or fields where required
 
        * tint_switch_thumb: used exclusively for the tops of UISwitches
 
        * highlight_*: the colors used for Highlighting
 
        * array_sectionColors: Colors for the Section objects will be set by
          cycling though this array.
 
*/// ---------------------------------------------------------------------------

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

@property (nonatomic) NSArray *array_sectionColors;

- (void)changeColorProfile: (NSString *) colorProfile;

@end
