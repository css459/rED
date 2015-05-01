//
//  Notebook.h
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

/* ---<<SINGLETON>>-------------------------------------------------------------
 
    The Notebook is like the "Settings" but for user-created content
    like highlights and notes. 
 
    There should only ever be ONE instance of Notebook, just like Settings.
 
    The Notebook stores these objects:
 
        * array_sections: The array of Section objects
 
        * array_highlights: The array of highlighted quotations from ALL
          Pages. Although Page objects will maintain their own array of 
          highlighted content, this array should consolidate all highlights.
 
        * lastLoadedSection: The Section object last displayed by the Notebook
          View Controller. Loaded when that View Controller is displayed.
 
*/// ---------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "Section.h"

@interface Notebook : NSObject <NSCoding>

// Object Storage
@property (nonatomic, strong) NSMutableArray *array_sections;
@property (nonatomic, strong) NSMutableArray *array_highlights;
@property NSUInteger indexOfLastLoadedSection;

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
