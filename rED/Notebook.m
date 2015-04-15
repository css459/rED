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
    Settings *usersettings;
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
        usersettings = [Settings sharedSettings];
        
        Section *rootSection = [[Section alloc] initWithTitle:@"Main Tab"];
        [self saveSection:rootSection];
        
        indexOfLastLoadedSection = 0;
        
    }
    return self;
}

#pragma mark - Utility Methods

- (NSArray *)aggregateHighlightsFromPages {
    NSMutableArray *array_intake;
    
    if (usersettings.array_pages.count != 0) {
        
        for (Page *p in [usersettings array_pages]) {
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

- (BOOL)saveSection:(Section *)section {
    NSUInteger originalCount;
    NSUInteger postCount;
    
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
    NSUInteger originalCount;
    NSUInteger postCount;
    
    if (self.array_sections != 0) {
        originalCount = self.array_sections.count;
        [self.array_sections removeObjectAtIndex:section.indexInArray];
        postCount = self.array_sections.count;
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
        sharedNotebook = [[self alloc] init];
    });
    return sharedNotebook;
}

@end
