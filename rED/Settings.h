//
//  Settings.h
//  rED
//
//  Created by Cole Smith on 2/6/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

/*
    The Settings object will maintain a globally accessible singleton
    that holds the parameters defined in the Settings View Controller
 */

#import <Foundation/Foundation.h>

@interface Settings : NSObject

@property BOOL nightMode;
@property BOOL tutorialMode;
@property int textSize;
@property NSString *homeSite;

@end
