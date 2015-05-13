//
//  Page.h
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notebook.h"

@interface Page : NSObject <NSCoding>

@property (nonatomic) NSString *title;                              // The title of the page, pulled from the web page itself.
@property (nonatomic) NSString *url;                                // The URL of the web page
@property (nonatomic) NSString *htmlContent;                        // HTML data pulled from the page for local mutation
@property (nonatomic) NSString *articleTitle;                       // Identical to "title" but used internally
@property (nonatomic) NSString *fileName;                           // The file name and extension when saved to disk for sharing
@property (nonatomic) NSDate *dateSaved;                            // Date when the HTML for the web page was captured
@property (nonatomic) NSMutableArray *array_highlightsFromPage;     // Array of highlights made on this page
@property (nonatomic) NSUInteger indexInArray;                      // Index of page in array_pages (Settings) for ID purposes
@property (nonatomic) BOOL pageHasEdits;                            // BOOL flag to signal an unedited, unsaved page
@property (nonatomic) NSDictionary *htmlDictionary;                 // HTML dictionary delcarations

// Initializers
- (instancetype)initWithURL:(NSString *)urlAddress html:(NSString *)HTML;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

// Supporting Methods
- (BOOL)checkForEdits;
- (void)formatTitle;
- (NSString *)formatDate;

// Archiving
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (NSString *)generateFileForSharing;
- (void)endSharing;

@end
