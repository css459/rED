//
//  NotebookManagerTableViewController.h
//  rED
//
//  Created by Cole Smith on 2/21/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotesViewController.h"

@interface NotebookManagerTableViewController : UITableViewController

@property (nonatomic) NotesViewController *referenceToNotesViewController;
@property (strong, nonatomic) IBOutlet UITableView *presentingTableView;

- (IBAction)button_addWasPressed:(id)sender;

@end
