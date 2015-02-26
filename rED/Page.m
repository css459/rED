//
//  Page.m
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "Page.h"
#import "Notebook.h"

@implementation Page

@synthesize url, htmlContent, dateSaved, notebook;

- (id)initWithURL:(NSString *)urlAddress withHTML:(NSString *)HTML withDateSaved:(NSString *)date withNoteBook:(Notebook *)nb
{
    url = urlAddress;
    htmlContent = HTML;
    dateSaved = date;
    notebook = nb;
    
    return self;
}

-(void)savePage:(Page *)p
{
    
}

@end
