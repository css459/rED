//
//  Highlight.m
//  rED
//
//  Created by Cole Smith on 2/20/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "Highlight.h"
#import "ColorPalette.h"
#import "Page.h"

@interface Highlight ()
{
    ColorPalette *cp;
}
@end

@implementation Highlight
@synthesize quote, color, containingPage;

#pragma mark - Initializers

- (instancetype)init {
    self = [super init];
    if (self) {
        Page *placeHolderPage = [[Page alloc] init];
        self = [self initWithQuote:@"No Quote" color:[UIColor blackColor] page:placeHolderPage];
    }
    return self;
}

- (instancetype)initWithQuote:(NSString *)qo color:(UIColor *)col page:(Page *)pg {
    self = [super init];
    if (self) {
        quote = qo;
        color = col;
        containingPage = pg;
    }
    return self;
}

- (NSString *)formatQuotationForInjection {
    NSString *stringForReturn;
    stringForReturn = [NSString stringWithFormat:@"\"%@\" - %@", quote, containingPage.title];
    return stringForReturn;
}

#pragma mark - Archiving

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:quote forKey:@"quote"];
    [aCoder encodeObject:color forKey:@"color"];
    [aCoder encodeObject:containingPage forKey:@"containingPage"];
}
@end
