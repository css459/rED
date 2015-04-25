//
//  SectionTableViewCell.m
//  rED
//
//  Created by Cole Smith on 4/25/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "SectionTableViewCell.h"

@implementation SectionTableViewCell
@synthesize label_sectionColor, label_sectionTitle;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
