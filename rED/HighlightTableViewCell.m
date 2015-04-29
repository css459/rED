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

- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
