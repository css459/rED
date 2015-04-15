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
#import "Page.h"

@interface Settings : NSObject

// Application Parameters
@property BOOL nightMode;
@property BOOL tutorialMode;
@property BOOL sharingMode;
@property double textSize;
@property (nonatomic) NSString *homeSite;

// Object Storage
@property (strong, nonatomic) NSMutableArray *array_pages;  // Here, we will save pages.

// Page Data Management
- (BOOL)savePage:(Page *)page;
- (BOOL)removePage:(Page *)page;

// Singleton Methods
+ (id)sharedSettings;

@end
