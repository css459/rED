//
//  ColorPalette.h
//  Shorecrest Web Browser
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

// The main red color that should be used tints where appropriate
@property UIColor *master_red;

@end
