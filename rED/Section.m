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
@end
