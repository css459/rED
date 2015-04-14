//
//  Section.m
//  rED
//
//  Created by Cole Smith on 3/25/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "Section.h"
#import "ColorPalette.h"
#import "Notebook.h"

@interface Section ()
{
    ColorPalette *cp;
    Notebook *sharedNotebook;
}
@end

@implementation Section
@synthesize title, color, textContent, dateCreated, isLastLoadedSection, indexInArray;

#pragma mark - Initializers

- (instancetype)init {
    NSString *ttl = @"Untitled Section";
    return [self initWithTitle:ttl];
}

- (instancetype)initWithTitle:(NSString *)ttl {
    self = [super init];
    if (self) {
        sharedNotebook = [Notebook sharedNotebook];
        title = ttl;
        color = [cp.array_sectionColors objectAtIndex:0];
        textContent = @"(Placeholder)";
        dateCreated = [NSDate date];
        isLastLoadedSection = NO;
    }
    return self;
}

#pragma mark - Section Saving

- (BOOL)saveSection{
    NSUInteger originalCount;
    NSUInteger postCount;
    
    originalCount = sharedNotebook.array_sections.count;
    [sharedNotebook.array_sections addObject:self];
    postCount = sharedNotebook.array_sections.count;
    indexInArray = postCount;
    
    if (postCount == (originalCount + 1)) {
        NSLog(@"Section Saved Successfully - Array count: %lu", (unsigned long)sharedNotebook.array_sections.count);
        return YES;
    } else {
        NSLog(@"SECTION SAVE FAILED - Array count: %lu", (unsigned long)sharedNotebook.array_sections.count);
        return NO;
    }

}

- (BOOL)removeSection{
    NSUInteger originalCount;
    NSUInteger postCount;
    
    if (sharedNotebook.array_sections != 0) {
        originalCount = sharedNotebook.array_sections.count;
        [sharedNotebook.array_sections removeObjectAtIndex:indexInArray];
        postCount = sharedNotebook.array_sections.count;
    }
    
    if (postCount == (originalCount - 1)) {
        NSLog(@"Section Removed Successfully - Array count: %lu", (unsigned long)sharedNotebook.array_sections.count);
        return YES;
    } else {
        NSLog(@"SECTION REMOVAL FAILED - Array count: %lu", (unsigned long)sharedNotebook.array_sections.count);
        return NO;
    }
}

#pragma mark - Supporting Actions

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSString *dateString = [format stringFromDate:date];
    
    return dateString;
}

@end
