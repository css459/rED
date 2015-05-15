//
//  HighlightsTableViewController.m
//  rED
//
//  Created by Cole Smith on 2/20/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "HighlightsTableViewController.h"
#import "ColorPalette.h"
#import "Highlight.h"
#import "Notebook.h"
#import "HighlightTableViewCell.h"
#import "Page.h"

@interface HighlightsTableViewController ()
{
    ColorPalette *cp;
    Notebook *sharedNotebook;
    Page *sharedPage;
    
    int sectionsCount;
    int rowsCount;
}
@end

@implementation HighlightsTableViewController
@synthesize toolbar, segmentedControl_sortingOption;

#pragma mark - Initilizers

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        cp = [[ColorPalette alloc] init];
        sharedNotebook = [Notebook sharedNotebook];
        
        // Model Highlight
        
        Page *newPage = [[Page alloc] init];
        Highlight *model = [[Highlight alloc] init];
        model.quote = @"Yellow";
        model.containingPage = newPage;
        model.containingPage.title = @"New York Times";
        model.color = [cp highlight_yellow];
        
        [sharedNotebook.array_highlights addObject:model];
        newPage = [[Page alloc] init];
        model = [[Highlight alloc]init];
        model.quote = @"Blue";
        model.containingPage.title = @"Chicago Tribune";
        model.color = [cp highlight_blue];
        
        [sharedNotebook.array_highlights addObject:model];
        newPage = [[Page alloc] init];
        model = [[Highlight alloc]init];
        model.quote = @"Red";
        model.containingPage.title = @"Daily Mail";
        model.color = [cp highlight_red];
        
        [sharedNotebook.array_highlights addObject:model];
        newPage = [[Page alloc]init];
        model = [[Highlight alloc]init];
        model.quote = @"Orange";
        model.containingPage.title = @"Washington Post";
        model.color = [cp highlight_orange];
        
        [sharedNotebook.array_highlights addObject:model];
        
        NSLog(@"array_highlights Contents: %@",sharedNotebook.array_highlights);
        
        sharedPage = [[Page alloc]init];
        
        Highlight *pageModel = [[Highlight alloc]init];
        
        pageModel = [[Highlight alloc]init];
        pageModel.containingPage = sharedPage;
        pageModel.quote = @"Blue";
        pageModel.containingPage.title = @"Los Angeles Tribune";
        pageModel.color = [cp highlight_blue];
        
        [sharedPage.array_highlightsFromPage addObject:pageModel];
        
        pageModel = [[Highlight alloc]init];
        pageModel.containingPage = sharedPage;
        pageModel.quote = @"Orange";
        pageModel.containingPage.title = @"Boston Times";
        pageModel.color = [cp highlight_orange];
        
        [sharedPage.array_highlightsFromPage addObject:pageModel];
        
        pageModel = [[Highlight alloc]init];
        pageModel.containingPage = sharedPage;
        pageModel.quote = @"Red";
        pageModel.containingPage.title = @"The Guardian";
        pageModel.color = [cp highlight_red];
        
        [sharedPage.array_highlightsFromPage addObject:pageModel];
        
        pageModel = [[Highlight alloc]init];
        pageModel.containingPage = sharedPage;
        pageModel.quote = @"Yellow";
        pageModel.containingPage.title = @"BBC";
        pageModel.color = [cp highlight_yellow];

        [sharedPage.array_highlightsFromPage addObject:pageModel];
        
        NSLog(@"array_highlightsFromPage Contents: %@",sharedPage.array_highlightsFromPage);
    }
    return self;
}

#pragma mark - View Handlers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Implements custom title with formatting
    [self.navigationController setNavigationBarHidden:NO];
    UILabel *naviTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    UIFont *titleFont = [UIFont fontWithName:@"Bodoni 72 Oldstyle" size:20.0];
    [naviTitle setText:@"Highlights"];
    [naviTitle setFont:titleFont];
    [naviTitle setTextColor:[cp tint_text]];
    [naviTitle sizeToFit];
    self.navigationItem.titleView = naviTitle;
    
    // Toolbar Implementation
    [toolbar setTintColor:[cp tint_accent]];
//    [toolbar setBarTintColor:[cp tint_background]];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateColorScheme {}

#pragma mark - Action Handlers


- (IBAction)segmentedControl_sortingOptionDidChange:(id)sender {
//    switch (self.segmentedControl_sortingOption.selectedSegmentIndex) {
//        case 0:
//            // "From Current Page"
//            // Displays tableView of highlights from current page
//            // John is currently making method for this ^^
//            
//            break;
//        case 1:
//            // "All Highlights"
//            // Displays tableView of all highlights
//
//
//         
//            break;
//        default:
//            break; 
//    }
    
    
    
    [[self tableView] reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    
    if (segmentedControl_sortingOption) {
        return 1;
    } else {
        return sectionsCount;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementxation.
    // Return the number of rows in the section.
    
    if (segmentedControl_sortingOption) {
        return 4;
    } else {
        return rowsCount;
    }    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HighlightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_Highlight"];
    Highlight *allHighlightsAtIndex = [sharedNotebook.array_highlights objectAtIndex:indexPath.row];
    NSLog(@"All Highlights:  %@", allHighlightsAtIndex);
    Highlight *pageHighlightsAtIndex = [sharedPage.array_highlightsFromPage objectAtIndex:indexPath.row];
    NSLog(@"Page Highlight:  %@", pageHighlightsAtIndex);
    
    switch (self.segmentedControl_sortingOption.selectedSegmentIndex) {
        case 0:
            
            cell.cellLabel_pageTitle.text = pageHighlightsAtIndex.containingPage.title;
            cell.cellLabel_quotation.text = pageHighlightsAtIndex.quote;
            cell.cellLabel_colorBar.backgroundColor = pageHighlightsAtIndex.color;
            break;
            
        case 1:
            
            cell.cellLabel_pageTitle.text = allHighlightsAtIndex.containingPage.title;
            cell.cellLabel_quotation.text = allHighlightsAtIndex.quote;
            cell.cellLabel_colorBar.backgroundColor = allHighlightsAtIndex.color;
        
            break;
            
        default:
            break;
    }
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
