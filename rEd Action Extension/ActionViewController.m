//
//  ActionViewController.m
//  rEDExtension
//
//  Created by Comp_Sci on 3/6/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "ActionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "PagesViewController.h"

@interface ActionViewController ()
@end

@implementation ActionViewController
@synthesize webview;

#pragma mark - View Handlers

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSURL *url = [NSURL URLWithString:@"rED://"];
//    NSString * content = [NSString stringWithFormat : @"<head><meta http-equiv='refresh' content='0; URL=%@'></head>", url];
//    [webview loadHTMLString:content baseURL:nil];
    
    //[webview stringByEvaluatingJavaScriptFromString:@"javascript:window.location=\"rED://?url=\"+window.location"];
    NSString *currentURL = [webview stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    NSString *openRED = [NSString stringWithFormat:@"rED://%@", currentURL];
    NSLog(@"openRED: %@", openRED);
    [webview loadHTMLString:openRED baseURL:nil];

    //    NSString *rEDContent = [NSString stringWithFormat:@"<head><meta http-equiv='refresh' content='0; URL=%@'></head>", openRED];
//    [webview loadHTMLString:rEDContent baseURL:nil];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [self done];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action Handlers

- (IBAction)done {
    
    // Return any edited content to the host app.
    // This template doesn't do anything, so we just echo the passed in items.
    [self.extensionContext completeRequestReturningItems:self.extensionContext.inputItems completionHandler:nil];
}

@end
