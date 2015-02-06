//
//  Settings.m
//  rED
//
//  Created by Cole Smith on 2/6/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "Settings.h"

@implementation Settings
@synthesize homeSite;

+ (Settings *)sharedSettings {
    static Settings *sharedSettings = nil;
    if (!sharedSettings) {
        sharedSettings = [[super allocWithZone:nil] init];
    }
    return sharedSettings;
}

- (id)init {
    self = [super init];
    if (self) {
        homeSite = [[NSString alloc] init];
    }
    return self;
    
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedSettings];
}


@end
