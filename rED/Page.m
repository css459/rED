//
//  Page.m
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "Page.h"
#import "Notebook.h"
#import "Settings.h"
#import "AppDelegate.h"

@implementation Page
@synthesize url, htmlContent, dateSaved, array_highlightsFromPage, pageHasEdits, indexInArray, htmlDictionary, articleTitle, title, isLastLoadedPage;

#pragma mark - Initalizers

- (instancetype)init {
    return [self initWithURL:nil html:nil];
}

- (instancetype)initWithURL:(NSString *)urlAddress html:(NSString *)HTML {
    self = [super init];
    if (self) {
        url = urlAddress;
        htmlContent = HTML;
        dateSaved = [NSDate date];
        array_highlightsFromPage = [[NSMutableArray alloc]init];
        NSLog(@"INITWITHURLRECEIVED: %@", url);
        [self formatTitle];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        dateSaved = [aDecoder decodeObjectForKey:@"dateSaved"];
        title = [aDecoder decodeObjectForKey:@"title"];
        url = [aDecoder decodeObjectForKey:@"url"];
        htmlContent = [aDecoder decodeObjectForKey:@"htmlContent"];
        array_highlightsFromPage = [aDecoder decodeObjectForKey:@"array_highlightsFromPage"];
        indexInArray = [aDecoder decodeIntegerForKey:@"indexInArray"];
        pageHasEdits = [aDecoder decodeBoolForKey:@"pageHasEdits"];
        isLastLoadedPage = [aDecoder decodeBoolForKey:@"isLastLoadedPage"];
        htmlDictionary = [aDecoder decodeObjectForKey:@"htmlDictionary"];
        articleTitle = [aDecoder decodeObjectForKey:@"articleTitle"];
    }
    return self;
}

#pragma mark - Supporting Methods

- (BOOL)checkForEdits {
    if (array_highlightsFromPage.count > 0) {
        pageHasEdits = YES;
        return YES;
    } else {
        pageHasEdits = NO;
        return NO;
    }
}

- (void)formatTitle {
    // Grab the Page title from the web page at URL
    // URLString is the URL from which the data is downloaded from
    NSString *URLString = [NSString stringWithFormat:@"https://www.readability.com/api/content/v1/parser?url=%@&token=79df0f9969a83dfb8759ba33c4530d6d04ffe87f", url];
    
    // NSString is converted to a NSURL
    NSURL *websiteUrl = [NSURL URLWithString:URLString];
    
    // Data download block
    [AppDelegate downloadDataFromURL:websiteUrl withCompletionHandler:^(NSData *data) {
        if (data != nil) {
            
            NSError *error;
            NSMutableDictionary *returnedDict = [NSJSONSerialization
                                                 JSONObjectWithData:data
                                                 options:kNilOptions
                                                 error:&error];
            if (error != nil) {
                NSLog(@"%@",[error localizedDescription]);
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"Uh-Oh!"
                                      message:@"The URL you requested is not compatible with rED :("
                                      delegate:nil
                                      cancelButtonTitle:@"Okay"
                                      otherButtonTitles:nil, nil];
                [alert show];
                
            } else {
                
                self.htmlDictionary = [returnedDict objectForKey:@"title"];
                
                // HTML Content property is set to contain the HTML code for the page
                articleTitle = [[self htmlDictionary] description];
                
                [self modifyArticleTitle:articleTitle];
            }
        }
    }];
    
}

- (void)modifyArticleTitle:(NSString *)ttl
{
    articleTitle = ttl;
    title = ttl;
    NSLog(@"Article title: %@", articleTitle);
}

- (NSString *)formatDate {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSString *dateString = [format stringFromDate:dateSaved];
    
    return dateString;
}

+(id)sharedPage {
    static Page *sharedPage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPage = [[self alloc]init]; });
    
    return sharedPage;
}

@end
