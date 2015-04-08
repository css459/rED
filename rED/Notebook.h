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

@interface Notebook : NSObject

@property (nonatomic) NSMutableArray *array_sections;
@property (nonatomic) NSMutableArray *array_highlights;
@property (nonatomic) Section *lastLoadedSection;

- (NSArray *)aggregateHighlightsFromPages;

+ (Notebook *)sharedNotebook;

@end
