//
//  Notebook.h
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

// <<SINGLETON>>

#import <Foundation/Foundation.h>
#import "Section.h"

@interface Notebook : NSObject <NSCoding>

// Object Storage
@property (nonatomic, strong) NSMutableArray *array_sections;       // Array of all Section objects
@property (nonatomic, strong) NSMutableArray *array_highlights;     // Array of all Highlights from all Pages
@property (nonatomic) NSUInteger indexOfLastLoadedSection;          // The index of the Section last loaded in NotesViewController
@property (nonatomic) NSString *fileName;                           // The file name and extension when saved to disk for sharing

// Initializers
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

// Supporting Methods
- (NSArray *)aggregateHighlightsFromPages;

// Section Data Management
- (BOOL)saveSection:(Section *)section;
- (BOOL)removeSection:(Section *)section;

// Singleton Methods
+ (id)sharedNotebook;

// Archiving
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (NSString *)generateFileForSharing;
- (void)importRecievedSectionToArray;
- (void)importSectionsFromRecievedNotebookToArray;

@end
