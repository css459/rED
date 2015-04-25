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
    int arrayIndexForColorCycle;
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
        title = ttl;
        color = [cp.array_sectionColors objectAtIndex:0];
        textContent = @"(Placeholder)";
        dateCreated = [NSDate date];
        isLastLoadedSection = NO;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        color = [aDecoder decodeObjectForKey:@"color"];
        title = [aDecoder decodeObjectForKey:@"title"];
        textContent = [aDecoder decodeObjectForKey:@"textContent"];
        dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
        indexInArray = [aDecoder decodeIntegerForKey:@"indexInArray"];
        isLastLoadedSection = [aDecoder decodeBoolForKey:@"isLastLoadedSection"];
    }
    return self;
}

#pragma mark - Supporting Actions

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSString *dateString = [format stringFromDate:date];
    
    return dateString;
}

- (void)cycleColors {
    if (arrayIndexForColorCycle == 9) {
        arrayIndexForColorCycle = -1;
    }
    arrayIndexForColorCycle++;
    self.color = [cp.array_sectionColors objectAtIndex:arrayIndexForColorCycle];
    NSLog(@"count: %lu", (unsigned long)cp.array_sectionColors.count);
    NSLog(@"color at index: %@", [cp.array_sectionColors objectAtIndex:arrayIndexForColorCycle]);
}

#pragma mark - Archiving

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:color forKey:@"color"];
    [aCoder encodeObject:title forKey:@"title"];
    [aCoder encodeObject:textContent forKey:@"textContent"];
    [aCoder encodeObject:dateCreated forKey:@"dateCreated"];
    [aCoder encodeInteger:indexInArray forKey:@"indexInArray"];
    [aCoder encodeBool:isLastLoadedSection forKey:@"isLastLoadedSection"];
}

@end
