//
//  Settings.m
//  rED
//
//  Created by Cole Smith on 2/6/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "Settings.h"
#import "Page.h"

@implementation Settings
@synthesize homeSite, textSize, nightMode, tutorialMode, sharingMode, array_pages;

#pragma mark - Initializers

- (instancetype)init {
    self = [super init];
    if (self) {
        textSize = 25.0;
        nightMode = NO;
        tutorialMode = NO;
        sharingMode = NO;
        homeSite = @"about:blank";  // This is sort of a hack
        
        array_pages = [[NSMutableArray alloc] init];
    }
    return self;
    
}

#pragma mark - Singleton Methods

+ (id)sharedSettings {
    static Settings *sharedSettings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSettings = [[self alloc] init];
    });
    return sharedSettings;
}

# pragma mark - Page Data Management

- (BOOL)savePage:(Page *)page {
    NSUInteger originalCount;
    NSUInteger postCount;
    
    originalCount = self.array_pages.count;
    [self.array_pages addObject:page];
    postCount = self.array_pages.count;
    page.indexInArray = postCount - 1;
    
    if (postCount == (originalCount + 1)) {
        NSLog(@"Page Saved Successfully - Array count: %lu", (unsigned long)self.array_pages.count);
        return YES;
    } else {
        NSLog(@"PAGE SAVE FAILED - Array count: %lu", (unsigned long)self.array_pages.count);
        return NO;
    }
}

- (BOOL)removePage:(Page *)page {
    NSUInteger originalCount;
    NSUInteger postCount;
    
    if (self.array_pages != 0) {
        originalCount = self.array_pages.count;
        [self.array_pages removeObjectAtIndex:page.indexInArray];
        postCount = self.array_pages.count;
    }
    
    if (postCount == (originalCount - 1)) {
        NSLog(@"Page Removed Successfully - Array count: %lu", (unsigned long)self.array_pages.count);
        return YES;
    } else {
        NSLog(@"PAGE REMOVAL FAILED - Array count: %lu", (unsigned long)self.array_pages.count);
        return NO;
    }
}


@end
