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
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorPalette : NSObject

@property UIColor *tint_accent;
@property UIColor *tint_text;
@property UIColor *tint_background;

- (void)changeColorProfile: (NSString *) colorProfile;
@end
