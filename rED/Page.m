//
//  Page.m
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "Page.h"
#import "Notebook.h"
#import "Settings.h"

@implementation Page
@synthesize url, htmlContent, dateSaved, array_highlightsFromPage, pageHasEdits, indexInArray;

#pragma mark - Initalizers

- (instancetype)init {
    self = [super init];
    if (self) {
        url = nil;
        htmlContent = nil;
        dateSaved = [NSDate date];
    }
    return self;
}

- (instancetype)initWithURL:(NSString *)urlAddress html:(NSString *)HTML {
    self = [super init];
    if (self) {
        url = urlAddress;
        htmlContent = HTML;
        dateSaved = [NSDate date];
    }
    return self;
}

#pragma mark - Data Management

// Properly saves a page, returns a status check per operation
- (BOOL)saveSelfToArray {
    Settings *userSettings = [Settings sharedSettings];
    NSUInteger originalCount;
    NSUInteger postCount;
    
    originalCount = userSettings.array_pages.count;
    [userSettings.array_pages addObject:self];
    postCount = userSettings.array_pages.count;
    indexInArray = postCount;
    
    if (postCount == (originalCount + 1)) {
        NSLog(@"Page Saved Successfully - Array count: %lu", (unsigned long)userSettings.array_pages.count);
        return YES;
    } else {
        NSLog(@"PAGE SAVE FAILED - Array count: %lu", (unsigned long)userSettings.array_pages.count);
        return NO;
    }
}

// Properly removes a page, returns a status check per operation
- (BOOL)removeSelfFromArray {
    Settings *userSettings = [Settings sharedSettings];
    NSUInteger originalCount;
    NSUInteger postCount;
    
    if (userSettings.array_pages != 0) {
        originalCount = userSettings.array_pages.count;
        [userSettings.array_pages removeObjectAtIndex:indexInArray];
        postCount = userSettings.array_pages.count;
    }
    
    if (postCount == (originalCount - 1)) {
        NSLog(@"Page Removed Successfully - Array count: %lu", (unsigned long)userSettings.array_pages.count);
        return YES;
    } else {
        NSLog(@"PAGE REMOVAL FAILED - Array count: %lu", (unsigned long)userSettings.array_pages.count);
        return NO;
    }
}

#pragma mark - Supporting Actions

- (BOOL)checkForEdits {
    if (array_highlightsFromPage.count > 0) {
        pageHasEdits = YES;
        return YES;
    } else {
        pageHasEdits = NO;
        return NO;
    }
}

#warning incomplete method implementation
- (NSString *)formatTitle {
    // Grab the Page title from the web page at URL
    return nil;
}

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSString *dateString = [format stringFromDate:date];
    
    return dateString;
}

@end
