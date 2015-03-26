//
//  Section.m
//  rED
//
//  Created by Cole Smith on 3/25/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "Section.h"
#import "ColorPalette.h"

@interface Section ()
{
    ColorPalette *cp;
}
@end

@implementation Section
@synthesize title, color, textContent, dateCreated;

#pragma mark - Initializers

- (instancetype)init {
    self = [super init];
    if (self) {
        cp = [[ColorPalette alloc] init];
        
        title = @"New Notebook Section";
        color = [cp.array_sectionColors objectAtIndex:0];
        textContent = @"";
        dateCreated = [NSDate date];
    }
    return self;
}

- (instancetype)initWithTitle: (NSString *)ttl {
    self = [super init];
    if (self) {
        title = ttl;
        color = [cp.array_sectionColors objectAtIndex:0];
        textContent = @"";
        dateCreated = [NSDate date];
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

@end
