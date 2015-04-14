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
        [rootSection saveSection];
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
