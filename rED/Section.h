//
//  Section.h
//  rED
//
//  Created by Cole Smith on 3/25/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Section : NSObject <NSCoding>

// Section Parameters
@property (nonatomic) UIColor *color;               // Section color
@property (nonatomic) NSString *title;              // Section title
@property (nonatomic) NSString *textContent;        // The notes and text saved in the Section
@property (nonatomic) NSString *fileName;           // The file name and extension when saved to disk for sharing
@property (nonatomic) NSDate *dateCreated;          // The date when the Section was created
@property (nonatomic) NSUInteger indexInArray;      // Index of page in array_sections (Notebook) for ID purposes
@property (nonatomic) BOOL isLastLoadedSection;     // BOOL flag to designate Section as last loaded

// Initializers
- (instancetype)initWithTitle:(NSString *)ttl;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

// Supporting Methods
- (NSString *)formatDate:(NSDate *)date;
- (void)cycleColors;

// Archiving
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (NSString *)generateFileForSharing;

@end
