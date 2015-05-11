//
//  Highlight.h
//  rED
//
//  Created by Cole Smith on 2/20/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

/* -----------------------------------------------------------------------------
 
     The Hightlight object stores the quotation highlighted on a
     Page.
 
     A Highlight stores these objects:
 
        * quote: A string of the highlighted quote from Page Default: nil
 
        * color: The color of the highlight, chosen at time of highlighting
          Default: highlight_yellow
 
        * containingPage: Reference back to the Page object from the web page
          that the Highlight came from. Default: nil
 
    A Highlight will always occur in a unique circumstance. Therefore, the 
    Defaut initializer should NEVER be called outside of testing circumstances.
 
 */// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Page.h"

@interface Highlight : NSObject <NSCoding>

@property (nonatomic) NSString *quote;
@property (nonatomic) UIColor *color;

@property (nonatomic) Page *containingPage;

// Initializers
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

// Supporting Methods
- (NSString *)formatQuotationForInjection;

// Archiving
- (void)encodeWithCoder:(NSCoder *)aCoder;

@end
