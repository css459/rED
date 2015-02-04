//
//  ColorPalette.m
//  Shorecrest Web Browser
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//
 
#import "ColorPalette.h"

@implementation ColorPalette
@synthesize master_red;

- (id)init {
    master_red = [[UIColor alloc] initWithRed:187.0 green:28.0 blue:29.0 alpha:1.0];
    
    return self;
}
@end
