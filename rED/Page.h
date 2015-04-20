//
//  Page.h
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

/* -----------------------------------------------------------------------------
 
    The Page object outlines the saved pages that the user creates.
    Pages are to be displayed by the Table View Controller for Saved Pages.
 
    A Page object contains:
 
        * title: The title of the page, pulled from the web page itself.
          Default: nil
 
        * url: The URL of the web page. Default: nil
 
        * htmlContent: The html of the page, pulled from web page.
          Default: nil
 
        * array_highlightsFromPage: Array of Highlight objects referencing
          the same Page object. Default: nil
 
        * dateSaved: Date object of the current date. No default, set at time 
          time of initialization.
 
        * indexInArray: Allows us to properly track down a page in the array
          with a unique identifier. Default: nil
 
        * pageHasEdits: The page is highlighted or otherwise appended from
          its orginal state from the web page it came from. Default: False
 
 */// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "Notebook.h"

@interface Page : NSObject

@property (nonatomic) NSDate *dateSaved;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *url;
@property (nonatomic) NSString *htmlContent;
@property (nonatomic) NSMutableArray *array_highlightsFromPage;
@property (nonatomic) NSUInteger indexInArray;
@property (nonatomic) BOOL pageHasEdits;
@property (weak, nonatomic) NSDictionary *htmlDictionary;
@property (strong, nonatomic) NSString *articleTitle;

// Initializers
- (instancetype)initWithURL:(NSString *)urlAddress html:(NSString *)HTML;

// Supporting Actions
- (BOOL)checkForEdits;
- (void)formatTitle;
- (NSString *)formatDate;

@end
