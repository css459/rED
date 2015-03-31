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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"rED://"];
    NSString * content = [NSString stringWithFormat : @"<head><meta http-equiv='refresh' content='0; URL=%@'></head>", url];
    [webview loadHTMLString:content baseURL:nil];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self done];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done {
    // Return any edited content to the host app.
    // This template doesn't do anything, so we just echo the passed in items.
    
    [self.extensionContext completeRequestReturningItems:self.extensionContext.inputItems completionHandler:nil];

}

@end
