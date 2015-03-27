//
//  Page.m
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "Page.h"
#import "Notebook.h"

@implementation Page
@synthesize url, htmlContent, dateSaved;

#pragma mark - Initalizers

- (instancetype)init {
    self = [super init];
    if (self) {
        url = nil;
        htmlContent = nil;
        dateSaved = [NSDate date];
    }
    return self;
}

- (instancetype)initWithURL:(NSString *)urlAddress html:(NSString *)HTML {
    self = [super init];
    if (self) {
        url = urlAddress;
        htmlContent = HTML;
        dateSaved = [NSDate date];
    }
    return self;
}

#pragma mark - Supporting Actions

#warning incomplete method implementation
- (NSString *)formatTitle {
    return nil;
}

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSString *dateString = [format stringFromDate:date];
    
    return dateString;
}

@end
