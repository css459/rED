//
//  SettingsViewController.h
//  Shorecrest Web Browser
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *label_TextPreview;
@property (weak, nonatomic) IBOutlet UISlider *slider_TextSize;

- (IBAction)slider_TextSizeDidChange:(id)sender;

@end
