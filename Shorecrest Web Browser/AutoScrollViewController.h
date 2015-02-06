//
//  AutoScrollViewController.h
//  Shorecrest Web Browser
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoScrollViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *button_Done;

- (IBAction)button_DoneWasPressed:(id)sender;

@end
