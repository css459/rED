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

@interface PagesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *button_SavePageProp;

- (IBAction)button_SavePage:(id)sender;

@end

