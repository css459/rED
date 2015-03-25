//
//  Settings.h
//  rED
//
//  Created by Cole Smith on 2/6/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

/* ---<<SINGLETON>>-------------------------------------------------------------
 
    The Settings object will maintain a globally accessible singleton.
    Therefore, there should only ever be ONE instance of Settings.
 
    The contents of Settings is dynamic and objects 
    may move in and out of Settings.
 
*///----------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface Settings : NSObject

@property BOOL nightMode;
@property BOOL tutorialMode;
@property double textSize;
@property (nonatomic) NSString *homeSite;

+(Settings *)sharedSettings;

@end
