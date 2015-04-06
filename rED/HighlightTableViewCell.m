//
//  HighlightTableViewCell.m
//  rED
//
//  Created by Cole Smith on 3/26/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "HighlightTableViewCell.h"

@implementation HighlightTableViewCell
@synthesize cellLabel_colorBar, cellLabel_pageTitle, cellLabel_quotation;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
