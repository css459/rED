//
//  SavedPagesTableViewController.h
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagesViewController.h"

@interface SavedPagesTableViewController : UITableViewController

// View Controller Properties
@property (nonatomic) PagesViewController *referenceToRootViewController;

// UI Element Properties
@property (strong, nonatomic) IBOutlet UITableView *presentingTableView;

// Action Handlers
- (void)gesture_SwipeLeft:(UISwipeGestureRecognizer*)gestureRecognizer;

@end
