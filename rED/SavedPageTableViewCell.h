//
//  SavedPageTableViewCell.h
//  rED
//
//  Created by Cole Smith on 4/15/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedPageTableViewCell : UITableViewCell

// Cell Properties
@property (weak, nonatomic) IBOutlet UILabel *label_savePage;
@property (weak, nonatomic) IBOutlet UILabel *label_dateAdded;
@property (weak, nonatomic) IBOutlet UITextView *textView_pagePreview;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
