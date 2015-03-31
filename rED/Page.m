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

#pragma mark - Storage Management

- (BOOL)saveSelfToArray {
    Settings *userSettings = [Settings sharedSettings];
    
    NSUInteger originalCount = userSettings.array_pages.count;
    [userSettings.array_pages addObject:self];
    NSUInteger postCount = userSettings.array_pages.count;
    indexInArray = postCount;
    
    if (postCount == (originalCount + 1)) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)removeSelfFromArray {
    Settings *userSettings = [Settings sharedSettings];
    
    NSUInteger originalCount = userSettings.array_pages.count;
    [userSettings.array_pages removeObjectAtIndex:indexInArray];
    NSUInteger postCount = userSettings.array_pages.count;
    
    if (postCount == (originalCount + 1)) {
        return YES;
    } else {
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
    return nil;
}

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSString *dateString = [format stringFromDate:date];
    
    return dateString;
}

@end
