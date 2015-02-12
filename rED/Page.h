//
//  Page.h
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

/*
    This object outlines the saved pages that the user creates. 
    This object should store the URL, the simplified text, and a Notebook object.
    These are the objects to be displayed by the Table View Controller for Saved Pages.
 */

/*
    To Pages developer,
        Please add an NSString property for the date created of the 'Page' object
        We'll need it for the subtitle of the cell in the Table View Controller.
 */

#import <Foundation/Foundation.h>

@interface Page : NSObject

@end
