//
//  HighlightsTableViewController.h
//  rED
//
//  Created by Cole Smith on 2/20/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighlightsTableViewController : UITableViewController

// Toolbar Properties
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl_sortingOption;

- (IBAction)segmentedControl_sortingOptionDidChange:(id)sender;

@end
