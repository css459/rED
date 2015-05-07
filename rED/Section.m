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
@synthesize title, color, textContent, dateCreated, isLastLoadedSection, indexInArray, fileName;

#pragma mark - Initializers

- (instancetype)init {
    NSString *ttl = @"Untitled Section";
    return [self initWithTitle:ttl];
}

- (instancetype)initWithTitle:(NSString *)ttl {
    self = [super init];
    if (self) {
        cp = [[ColorPalette alloc] init];
        title = ttl;
        color = [cp.array_sectionColors objectAtIndex:0];
        textContent = @"Welcome to your new section. You may begin typing here.";
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
        fileName = [aDecoder decodeObjectForKey:@"fileName"];
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
    cp = [[ColorPalette alloc] init];
    
    if (arrayIndexForColorCycle == 9) {
        arrayIndexForColorCycle = -1;
    }
    arrayIndexForColorCycle++;
    self.color = [cp.array_sectionColors objectAtIndex:arrayIndexForColorCycle];
}

#pragma mark - Archiving

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:color forKey:@"color"];
    [aCoder encodeObject:title forKey:@"title"];
    [aCoder encodeObject:textContent forKey:@"textContent"];
    [aCoder encodeObject:dateCreated forKey:@"dateCreated"];
    [aCoder encodeInteger:indexInArray forKey:@"indexInArray"];
    [aCoder encodeBool:isLastLoadedSection forKey:@"isLastLoadedSection"];
    [aCoder encodeObject:fileName forKey:@"fileName"];
}

- (NSString *)generateFileForSharing {
    NSArray *archiveDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *archivePath = [archiveDirectory objectAtIndex:0]; // What would this be?
    NSString *fileID = [NSString stringWithFormat:@"%@.redsection", self.title];
    NSString *directoryOfSavedSection = [archivePath stringByAppendingPathComponent:fileID];
    
    fileName = fileID;
    
    BOOL success = [NSKeyedArchiver archiveRootObject:self toFile:directoryOfSavedSection];
    NSLog(@"Section file creation completed with status: %d", success);
    
    return directoryOfSavedSection;
}

@end
