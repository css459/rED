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

@implementation ColorPalette
@synthesize tint_master_red, tint_darkGrey;

- (id)init {
    tint_master_red = [[UIColor alloc] initWithRed:187.0/255 green:28.0/255 blue:29.0/255 alpha:1.0];
    tint_darkGrey = [[UIColor alloc] initWithRed:40.0/255 green:40.0/255 blue:40.0/255 alpha:1.0];
    
    return self;
}
@end
