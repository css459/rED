//
//  Section.h
//  rED
//
//  Created by Cole Smith on 3/25/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

/* -----------------------------------------------------------------------------
 
     Sections are stored within the Notebook class. This object will be 
     displayed by the Notebook View Controller via the Notebook Object.
     
     Additionally, the Section objects will populate the cells in the Notebook
     Manager Table View Controller.
     
     A Section stores these objects:
 
         *Title: The section title. Default: "New Section"
         
         *Color: The section color which can be seen in the Notebook Manager
         Default: "paselRed" (array_sectionColor index 0)
         
         *textContent: A String formatted and displayed through 
         the Text View in NotesView Controller. Default: @""
         
         *dateCreated: A Date object used to store the date created. 
         This has no default and will be populated at the instance the 
         Section object is initialized.
 
 */// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Section : NSObject

// Section Parameters
@property (nonatomic) UIColor *color;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *textContent;
@property (nonatomic) NSDate *dateCreated;

// Initializers
- (instancetype)initWithTitle:(NSString *)ttl;

// Supporting Actions
- (NSString *)formatDate:(NSDate *)date;

@end
