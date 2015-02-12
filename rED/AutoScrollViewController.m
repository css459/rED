//
//  AutoScrollViewController.m
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

/*
 NOTE:
 
 *The behavior of scroll speed dialing has changed.
    Instead, we will use a gesture of scrolling thumb up in vc to increase
    scroll speed and down to decrease scroll speed.
 
    - This clears up the view and allows the device to be held more naturally without
    reaching for the toolbar
 
 */

#import "AutoScrollViewController.h"

@interface AutoScrollViewController ()

@end

@implementation AutoScrollViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
    
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// Switch to Home
- (IBAction)button_DoneWasPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
