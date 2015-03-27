//
//  HighlightTableViewCell.h
//  rED
//
//  Created by Cole Smith on 3/26/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighlightTableViewCell : UITableViewCell

// Cell Properties
@property (weak, nonatomic) IBOutlet UILabel *cellLabel_quotation;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel_pageTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel_colorBar;

@end
