//
//  Settings.h
//  rED
//
//  Created by Cole Smith on 2/6/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

// <<SINGLETON>>

#import <Foundation/Foundation.h>
#import "Page.h"

@interface Settings : NSObject <NSCoding>

// Application Parameters
@property BOOL nightMode;                                       // BOOL flag to initiate app-wide night color change
@property BOOL tutorialMode;                                    // BOOL flag to initiate app-wide tutorial presenting
@property BOOL sharingMode;                                     // BOOL flag to designate sharing Notebooks with Pages
@property double textSize;                                      // The text size for the presented simplified web page text
@property (nonatomic) NSString *homeSite;                       // The site that loads when no other page is instructed to load
@property (strong, nonatomic) NSMutableArray *array_pages;      // The array of all saved Page objects

// Initializers
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

// Page Data Management
- (BOOL)savePage:(Page *)page;
- (BOOL)removePage:(Page *)page;

// Singleton Methods
+ (id)sharedSettings;

// Archiving
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (void)importRecievedPageToArray;

@end
