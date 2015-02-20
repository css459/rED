//
//  Highlight.m
//  rED
//
//  Created by Cole Smith on 2/20/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "Highlight.h"
#import "ColorPalette.h"

@interface Highlight ()
{
    ColorPalette *cp;
}
@end

@implementation Highlight

- (instancetype)init {
    self = [super init];
    if (self) {
        cp = [[ColorPalette alloc] init];
    }
    return self;
}

@end
