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

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        nightMode = [aDecoder decodeBoolForKey:@"nightMode"];
        tutorialMode = [aDecoder decodeBoolForKey:@"tutorialMode"];
        sharingMode = [aDecoder decodeBoolForKey:@"sharingMode"];
        textSize = [aDecoder decodeDoubleForKey:@"textSize"];
        homeSite = [aDecoder decodeObjectForKey:@"homeSite"];
        array_pages = [aDecoder decodeObjectForKey:@"array_pages"];
    }
    return self;
}

# pragma mark - Page Data Management

- (BOOL)savePage:(Page *)page {
    NSUInteger originalCount = 0;
    NSUInteger postCount = 0;
    
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
    NSUInteger originalCount = 0;
    NSUInteger postCount = 0;
    
    if (self.array_pages != 0) {
        originalCount = self.array_pages.count;
        [self.array_pages removeObjectAtIndex:page.indexInArray];
        postCount = self.array_pages.count;
    }
    
    // Refresh the stored indexes for the Section objects
    for (NSUInteger i = 0; i < array_pages.count; i++) {
        [[array_pages objectAtIndex:i] setIndexInArray:i];
    }
    
    if (postCount == (originalCount - 1)) {
        NSLog(@"Page Removed Successfully - Array count: %lu", (unsigned long)self.array_pages.count);
        return YES;
    } else {
        NSLog(@"PAGE REMOVAL FAILED - Array count: %lu", (unsigned long)self.array_pages.count);
        return NO;
    }
}

#pragma mark - Singleton Methods

+ (id)sharedSettings {
    static Settings *sharedSettings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *archiveDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *archivePathForArray = [archiveDirectory objectAtIndex:0];
        NSString *directoryForArray = [archivePathForArray stringByAppendingPathComponent:@"UserDataBundle.archive"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:directoryForArray]) {
            NSArray *array_archivedSingletons = [NSKeyedUnarchiver unarchiveObjectWithFile:directoryForArray];
            sharedSettings = [array_archivedSingletons objectAtIndex:0];
        } else {
            sharedSettings = [[self alloc] init];
        }
    });
    
    return sharedSettings;
}

#pragma mark - Archiving

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:nightMode forKey:@"nightMode"];
    [aCoder encodeBool:tutorialMode forKey:@"tutorialMode"];
    [aCoder encodeBool:sharingMode forKey:@"sharingMode"];
    [aCoder encodeDouble:textSize forKey:@"textSize"];
    [aCoder encodeObject:homeSite forKey:@"homeSite"];
    [aCoder encodeObject:array_pages forKey:@"array_pages"];
}

- (void)importRecievedPageToArray {}

@end
