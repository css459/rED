//
//  PagesViewController.h
//  rED
//
//  Created by Cole Smith on 2/3/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

/*
 *** WAIT! ***
 If you're planning to write the implementation for this class, keep in mind
 it may need to be replaced with a Page View Controller to enable swiping between view controllers.
 */

#import <UIKit/UIKit.h>

@interface PagesViewController : UIViewController <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *button_SavePageProp;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) NSString *url;
@property (weak, nonatomic) NSString *htmlContent;
@property (weak, nonatomic) NSDictionary *htmlDictionary;

- (IBAction)button_SavePage:(id)sender;
- (void)gesture_SwipeLeft:(UISwipeGestureRecognizer*)gestureRecognizer;
- (void)gesture_SwipeRight:(UISwipeGestureRecognizer*)gestureRecognizer;

- (void)searchBarSearchButtonClicked:(UISearchBar *)sB;
- (void)getHTML:(NSString *)URL;
- (void)openHTML:(NSString *)html;

@end

