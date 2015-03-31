//
//  Settings.m
//  rED
//
//  Created by Cole Smith on 2/6/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "Settings.h"

@implementation Settings
@synthesize homeSite, textSize, nightMode, tutorialMode, sharingMode, array_pages;

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

+ (Settings *)sharedSettings {
    static Settings *sharedSettings = nil;
    if (!sharedSettings) {
        sharedSettings = [[super allocWithZone:nil] init];
    }
    return sharedSettings;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedSettings];
}


@end
