//
//  SectionTableViewCell.h
//  rED
//
//  Created by Cole Smith on 4/25/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_sectionTitle;
@property (weak, nonatomic) IBOutlet UILabel *label_sectionColor;

@end
