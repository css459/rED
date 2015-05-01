//
//  Notebook.m
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "Notebook.h"
#import "Highlight.h"
#import "Page.h"
#import "Settings.h"
#import "Section.h"

@interface Notebook ()
{
    Settings *sharedSettings;
}
@end

@implementation Notebook
@synthesize array_highlights, array_sections, indexOfLastLoadedSection;

#pragma mark - Initializers

- (instancetype)init {
    self = [super init];
    if (self) {
        array_highlights = [[NSMutableArray alloc] init];
        array_sections = [[NSMutableArray alloc] init];
        sharedSettings = [Settings sharedSettings];
        indexOfLastLoadedSection = 0;
        
        Section *rootSection = [[Section alloc] initWithTitle:@"Main Tab"];
        [self saveSection:rootSection];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        array_sections = [aDecoder decodeObjectForKey:@"array_sections"];
        array_highlights = [aDecoder decodeObjectForKey:@"array_highlights"];
        indexOfLastLoadedSection = [aDecoder decodeIntegerForKey:@"indexOfLastLoadedSection"];
    }
    return self;
}

#pragma mark - Supporting Methods

- (NSArray *)aggregateHighlightsFromPages {
    NSMutableArray *array_intake;
    
    if (sharedSettings.array_pages.count != 0) {
        
        for (Page *p in [sharedSettings array_pages]) {
            for (Highlight *h in p.array_highlightsFromPage) {
                [array_intake addObject:h];
            }
        }
        
        NSLog(@"Aggregated Pages Count: %lu", (unsigned long)array_intake.count);
        return array_intake;
        
    } else {
        return nil;
    }
}

#pragma mark - Section Data Management

- (BOOL)saveSection:(Section *)section {
    NSUInteger originalCount = 0;
    NSUInteger postCount = 0;
    
    originalCount = self.array_sections.count;
    [self.array_sections addObject:section];
    postCount = self.array_sections.count;
    section.indexInArray = postCount - 1;
    
    if (postCount == (originalCount + 1)) {
        NSLog(@"Section Saved Successfully - Array count: %lu", (unsigned long)self.array_sections.count);
        return YES;
    } else {
        NSLog(@"SECTION SAVE FAILED - Array count: %lu", (unsigned long)self.array_sections.count);
        return NO;
    }
}

- (BOOL)removeSection:(Section *)section {
    NSUInteger originalCount = 0;
    NSUInteger postCount = 0;
    
    if (self.array_sections != 0) {
        originalCount = self.array_sections.count;
        [self.array_sections removeObjectAtIndex:section.indexInArray];
        postCount = self.array_sections.count;
    }
    
    // Refresh the stored indexes for the Section objects
    for (NSUInteger i = 0; i < array_sections.count; i++) {
        [[array_sections objectAtIndex:i] setIndexInArray:i];
    }
    
    if (postCount == (originalCount - 1)) {
        NSLog(@"Section Removed Successfully - Array count: %lu", (unsigned long)self.array_sections.count);
        return YES;
    } else {
        NSLog(@"SECTION REMOVAL FAILED - Array count: %lu", (unsigned long)self.array_sections.count);
        return NO;
    }
}

#pragma mark - Singleton Methods

+ (id)sharedNotebook {
    static Notebook *sharedNotebook = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *archiveDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *archivePathForArray = [archiveDirectory objectAtIndex:0];
        NSString *directoryForArray = [archivePathForArray stringByAppendingPathComponent:@"UserDataBundle.archive"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:directoryForArray]) {
            NSArray *array_archivedSingletons = [NSKeyedUnarchiver unarchiveObjectWithFile:directoryForArray];
            sharedNotebook = [array_archivedSingletons objectAtIndex:1];
        } else {
            sharedNotebook = [[self alloc] init];
        }
    });
    
    return sharedNotebook;
}

#pragma mark - Archiving

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:array_highlights forKey:@"array_highlights"];
    [aCoder encodeObject:array_sections forKey:@"array_sections"];
    [aCoder encodeInteger:indexOfLastLoadedSection forKey:@"indexOfLastLoadedSection"];
}

- (NSString *)generateFileForSharing {
    NSArray *archiveDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *archivePath = [archiveDirectory objectAtIndex:1]; // What would this be?
    NSString *directoryOfSavedNotebook = [archivePath stringByAppendingPathComponent:@"Notebook.rednotebook"];
    
    BOOL success = [NSKeyedArchiver archiveRootObject:self toFile:directoryOfSavedNotebook];
    NSLog(@"Notebook file creation completed with status: %d", success);

    return directoryOfSavedNotebook;
}

- (void)importRecievedSectionToArray {}

- (void)importSectionsFromRecievedNotebookToArray {}

@end
