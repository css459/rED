//
//  Note.h
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

/*
 The Note object stores the notes data that the user creates
 Every "Notebook" object should have a Note object, less it be empty.
 
 Notes, when displayed in the Notes View Controller should follow this convention:
 
 "Vitae class luctus convallis vestibulum." - Line 42
 
 Here, the user will write a note about the quoted line above from the text
 The note should be indented as shown and have margins left aligned.
 Notes should be separated by a generous about of space or a thin line.
 
 The Note object should contain at least 3 things:
 
    * The string for the quotation from the web page
    * The string for the note the user takes
    * An int representing the line number.
 */

#import <Foundation/Foundation.h>

@interface Note : NSObject

@end
