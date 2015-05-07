//
//  Highlight.h
//  rED
//
//  Created by Cole Smith on 2/20/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Page.h"

@interface Highlight : NSObject <NSCoding>

@property (nonatomic) NSString *quote;          // The highlighted quote from the text
@property (nonatomic) UIColor *color;           // The colored that the text was highlighted in
@property (nonatomic) Page *containingPage;     // Reference to the page from which the highlight came

// Initializers
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

// Supporting Methods
- (NSString *)formatQuotationForInjection;

// Archiving
- (void)encodeWithCoder:(NSCoder *)aCoder;

@end
