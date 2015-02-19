//
//  PagesViewController.m
//  rED
//
//  Created by Cole Smith on 2/3/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "PagesViewController.h"
#import "ColorPalette.h"
#import "SavedPagesTableViewController.h"
#import "NotesViewController.h"
#import "Settings.h"
#import "AppDelegate.h"

@interface PagesViewController ()
{
    BOOL savedButtonState;
    ColorPalette *cp;
    Settings *userSettings;
}
@end

@implementation PagesViewController
@synthesize button_SavePageProp, searchBar, webView, url, htmlContent, htmlDictionary;

#pragma mark - Initalizers

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        savedButtonState = false;
        cp = [[ColorPalette alloc] init];
        userSettings = [Settings sharedSettings];
    }
    return self;
}

#pragma mark - View Handlers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Swipe Declarations
    UISwipeGestureRecognizer * swipeLeft = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(gesture_SwipeLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(gesture_SwipeRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
}

- (void)viewWillAppear:(BOOL)animated {
    // Hides the Navigation Bar on appearance
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action Handlers

// Handles toggling of saved button
- (IBAction)button_SavePage:(id)sender {
    savedButtonState = !savedButtonState;
    if (savedButtonState) {
        [button_SavePageProp setImage:[UIImage imageNamed:@"toolbar_Save_Clicked"]];
        // Here, the Page obj should be added to the cell array.
    } else {
        [button_SavePageProp setImage:[UIImage imageNamed:@"toolbar_Save_Unclicked"]];
        // Here, the Page obj should be removed from the cell array.
    }
}

// Allows user to exit editing
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

// Switch to Notebook
- (void)gesture_SwipeLeft:(UISwipeGestureRecognizer*)gestureRecognizer {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard
                                storyboardWithName:storyboardName
                                bundle:[NSBundle bundleForClass:[self class]]];
    
    NotesViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"NotesViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
}

// Switch to Saved Pages
- (void)gesture_SwipeRight:(UISwipeGestureRecognizer*)gestureRecognizer {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard
                                storyboardWithName:storyboardName
                                bundle:[NSBundle bundleForClass:[self class]]];
    
    SavedPagesTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SavedPagesTableViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
}

#pragma mark - HTML Handlers

// Called when URL search button is pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)sB {
    url = [NSString stringWithString:sB.text];
    
    // Formats the URL if it does not contain the "http://" prefix
    if ([url containsString:@"http://"]) {
        [self getHTML:url];
    } else {
        NSString *newUrl = [NSString stringWithFormat:@"http://%@", url];
        [self getHTML:newUrl];
    }
}

- (void)getHTML:(NSString *)URL {
    // URLString is the URL from which the data is downloaded from
    NSString *URLString = [NSString stringWithFormat:@"https://www.readability.com/api/content/v1/parser?url=%@&token=79df0f9969a83dfb8759ba33c4530d6d04ffe87f", URL];
    
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
                 self.htmlDictionary = [returnedDict objectForKey:@"content"];
                 
                 // HTML Content property is set to contain the HTML code for the page
                 self.htmlContent = [[self htmlDictionary] description];
                 
                 // HTML is opened in the UIWebView
                 [self openHTML:htmlContent];
             }
         }
     }];
}

#pragma mark - UIWebView Handlers

- (void)openHTML:(NSString *)html {
    //Loads UIWebView with HTML
    [webView loadHTMLString:html baseURL:nil];
}

@end
