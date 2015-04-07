//
//  Notebook.m
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "Notebook.h"

@implementation Notebook
@synthesize array_highlights, array_sections, lastLoadedSection;

- (instancetype)init {
    self = [super init];
    if (self) {
        array_highlights = [[NSMutableArray alloc] init];
        array_sections = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)aggregateHighlightsFromPages {
    NSMutableArray *array_intake;
    NSMutableArray *array_sortedReturn;
    
    return array_sortedReturn;
}

+ (Notebook *)sharedNotebook {
    static Notebook *sharedNotebook = nil;
    if (!sharedNotebook) {
        sharedNotebook = [[super allocWithZone:nil] init];
    }
    return sharedNotebook;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedNotebook];
}

@end
