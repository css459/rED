//
//  AutoScrollViewController.m
//  rED
//
//  Created by Cole Smith on 2/4/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

/*
 NOTE:
 
 *The behavior of scroll speed dialing has changed.
    Instead, we will use a gesture of scrolling thumb up in vc to increase
    scroll speed and down to decrease scroll speed.
 
    - This clears up the view and allows the device to be held more naturally without
    reaching for the toolbar
 
 */

#import "AutoScrollViewController.h"

@interface AutoScrollViewController ()

@end

@implementation AutoScrollViewController

@synthesize webView, scrollButton, scrollView, h, scrollVal, timer;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
    
    }
    h = 0;
    scrollVal = 0.0;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *htmlString = @
    "<div><div class=\"l-container\"><div class=\"el__leafmedia el__leafmedia--storyhighlights\"><div class=\"el__storyhighlights_wrapper\"><p class=\"el__storyhighlights\"><ul class=\"el__storyhighlights__list\"><li class=\"el__storyhighlights__item el__storyhighlights--normal\">\"Mother Nature makes the rules,\" says Massachusetts Gov. Charlie Baker</li><li class=\"el__storyhighlights__item el__storyhighlights--normal\">Schools will be closed again Tuesday in some areas, including Boston</li></ul></p></div></div><p class=\"zn-body__paragraph\">Bostonians have had it up to their eyeballs with the winter of 2015.</p><p class=\"zn-body__paragraph\">\"I can't believe this is my neighborhood. It's wild,\" Amy McHugh of Weymouth, Massachusetts, told <a href=\"http://www.wcvb.com/weather/mass-reeling-after-record-snowfall-closes-mbta-collapses-roofs/31182522\" target=\"_blank\">CNN affiliate WCVB-TV</a>.  \"I keep telling the kids, 'You're going to be telling your kids about this.' It's unimaginable.\"</p><p class=\"zn-body__paragraph\">Not only unimaginable, but record-setting.</p><p class=\"zn-body__paragraph\">\"It's only been 14 days, and we've gotten 70 to 80 inches of snow around the commonwealth,\" Gov. Charlie Baker said. \"This is pretty much unprecedented.</p><p class=\"zn-body__paragraph\">\"If I've learned one thing over the course of the past two weeks, it's (that) Mother Nature makes the rules,\" Baker said.</p><p class=\"zn-body__paragraph\">By Monday evening, the system had dumped an additional 22-plus inches on Boston, pushing it into the city's Top 5 for February snowstorms.</p><p class=\"zn-body__paragraph\">The 30-day total is even more impressive. At a fraction under 72 inches, it set a record.  In an average year, the city gets 47 inches of snow.</p><p class=\"zn-body__paragraph\">And even more snow could fall before the weekend. The National Weather Service is keeping close watch on a new storm that could bring more heavy snow Thursday and Friday.</p><p class=\"zn-body__paragraph\">It's enough to drive some folks a bit stir crazy.</p><p class=\"zn-body__paragraph\">One Boston resident used the hashtag #getmeoutofhere to describe his feelings.</p><p class=\"zn-body__paragraph\">Tuesday's priority, according to the Massachusetts Emergency Management Agency, is to assist cities with digging out. </p><p class=\"zn-body__paragraph\">It will be clear enough Tuesday to allow trucks to remove snow from buried streets. </p><p class=\"zn-body__paragraph\">The state agency will help cities move snow to snow farms or, in some cases, into rivers, spokesman Peter Judge told CNN. </p><p class=\"zn-body__paragraph\">\"Everyone's been working full-bore for that last three weeks,\" Judge said, referring to the trucks removing as much snow as possible. </p><p class=\"zn-body__paragraph\">Eastern Massachusetts is running out of places to put all the white stuff.</p><p class=\"zn-body__paragraph\">There's so much snow that cities have been given permission to dump it in Boston Harbor, which is usually a no-no.</p><h3>School's out (again)</h3><p class=\"zn-body__paragraph\">Schools in parts of the Northeast, including Boston, will be closed again Tuesday.</p><p class=\"zn-body__paragraph\">Boston Mayor Marty Walsh said students haven't had a full week of classes in three weeks.  </p><p class=\"zn-body__paragraph\">They'll run out of snow days soon if the weather doesn't let up.</p><h3>Travel is a mess</h3><p class=\"zn-body__paragraph\">Boston remains under a snow emergency and parking ban. Cars left on city streets were being ticketed and towed to make room for snowplows.</p><p class=\"zn-body__paragraph\">The string of storms is taking a toll on city coffers. \"We've gone through our $18 million budget for snow removal,\" Walsh said.</p><p class=\"zn-body__paragraph\">The Massachusetts Bay Transportation Authority, known as the T, has suspended all rail services through the end of Tuesday. Limited bus service will be running.</p><p class=\"zn-body__paragraph\">Air travel across the Northeast should improve Tuesday.</p><p class=\"zn-body__paragraph\">More than 2,880 flights into and out of the United States were canceled Sunday and Monday, mostly because of the storm. Early Tuesday, less than 200 flights had been scrubbed for the day, according to <a href=\"http://flightaware.com/live/cancelled/today\" target=\"_blank\">FlightAware.com</a>.</p><p class=\"zn-body__paragraph\">Boston's Logan International Airport remained open during the storm, but most flights were canceled Monday. </p><h3>Courts are closed</h3><p class=\"zn-body__paragraph\">The weather forced a couple of big Massachusetts trials to be delayed.</p><p class=\"zn-body__paragraph\">The murder trial of former New England Patriots star <a href=\"http://www.cnn.com/2014/03/09/us/aaron-hernandez-fast-facts/index.html\">Aaron Hernandez</a> has been pushed back to Wednesday, and the same goes for jury selection in the trial of <a href=\"http://www.cnn.com/2013/06/03/us/boston-marathon-terror-attack-fast-facts/index.html\">Boston bombing</a> suspect Dzhokhar Tsarnaev.</p><h3>Coping with the snow</h3><p class=\"zn-body__paragraph\">Folks in the Northeast are known for being tough, but three snowstorms in three weeks is wearing a bit thin.</p><p class=\"zn-body__paragraph\">\"It's kind of depressing sometimes,\" Jesus Cora of Nashua, New Hampshire, told <a href=\"http://www.wmur.com/\" target=\"_blank\">CNN affiliate WMUR-TV</a>. \"It's really depressing, you know?\" Boston University freshman Cameron Barkan said, expressing the same sentiment.</p><p class=\"zn-body__paragraph\">\"I'm tired of it,\" said Barkan, who has missed three days of class because of the storms. \"I usually like snow, but this is just a little much.\"</p></div></div>";
    
    [webView loadHTMLString:htmlString baseURL:nil];

    
}


//- (CGPoint)locationInView:(UIView *)view;
//{
//}

//-(void)didSwipe:(UISwipeGestureRecognizer*)swipe
//{
//    
//    if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
//        timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
//    }else if (swipe.direction == UISwipeGestureRecognizerDirectionDown)
//    {
//        NSLog(@"swiped down");
//        timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(scroll) userInfo:nil repeats:YES];
//    }
//        
//    
//    
//}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//
//    [super touchesBegan:touches withEvent:event];
//
//    UITouch *firstTouch = [[event allTouches]anyObject];
//    CGPoint firstTouchLocation = [firstTouch locationInView:firstTouch.view];
//    
//
//    
//    NSLog(@"touches began");
//}
//
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesMoved:touches withEvent:event];
//    
//    UITouch *endTouch = [[event allTouches]anyObject];
//    CGPoint endTouchLocation = [endTouch locationInView:endTouch.view];

//    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didSwipe:)];
//    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
//    
//    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didSwipe:)];
//    upSwipe.direction = UISwipeGestureRecognizerDirectionDown;
//    
//    [[self view]addGestureRecognizer:upSwipe];
//    [[self view]addGestureRecognizer:downSwipe];
//    

    //if swiped up or down
//    NSLog(@"touches touches moved");
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//   
//    [super touchesEnded:touches withEvent:event];
//
//
//    
////    if (endTouch.y > ) {
////        //downswipe
////    }
//    
//    NSLog(@"touches ended");
//}



-(IBAction)stopButtonWasPressed:(id)sender
{
    
    [timer invalidate];
    timer = nil;

    
}
//-(IBAction)fastButtonWasPressed:(id)sender
//{
//    //speed up pace
//    
//}
//


//-(IBAction)slowButtonWasPressed:(id)sender
//{
//    timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(scroll) userInfo:nil repeats:YES];
////    if (//button pressed again ) {
////        //slow even more
////    }
//}

-(IBAction)scrollButtonWasPressed:(id)sender
{

    timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(scroll) userInfo:nil repeats:YES];
//    scrollButton.userInteractionEnabled = NO;
    
}

//This will be called every second
-(void)scroll
{
//    NSInteger height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] intValue];
//    
//    NSString* javascript = [NSString stringWithFormat:@"window.scrollBy(0, %ld);", height];
//    [webView stringByEvaluatingJavaScriptFromString:javascript];

    
    //=======================================================================================
    
    
    CGPoint bottomOffset = CGPointMake(0, self.webView.scrollView.contentSize.height - self.webView.scrollView.bounds.size.height);
    if (scrollVal < bottomOffset.y) {
        CGPoint scroll = CGPointMake(0, scrollVal);
        scrollVal += 1;
//        NSLog(@"contentSize = %f, scrollView = %f", self.webView.scrollView.contentSize.height, self.webView.scrollView.bounds.size.height);
        [self.webView.scrollView setContentOffset:scroll animated:YES];
        webView.scrollView.bounces = NO;
        
    } else {
        [timer invalidate];
        timer = nil;
    }
    
    
    
    //=======================================================================================
//    
//    for (int i = 0; i != self.webView.scrollView.contentSize.height - self.webView.scrollView.bounds.size.height; i++)
//    {
//       
//        [webView.scrollView setContentOffset:CGPointMake(0, i) animated:YES];
//    }
    
    
    //code to scroll web view x pixels down
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [timer invalidate];
    timer = nil;
}

- (void) webViewDidFinishLoad:(UIWebView *)docView
{
    if (![webView isLoading]) {
        
//
//        for (int k = 0; k < 0; k--) {
//            while (k != self.webView.scrollView.contentSize.height - self.webView.scrollView.bounds.size.height) {
//            
//                sleep(1.0)
//                CGPoint bottomOffset = CGPointMake(0, k);
//                [self.webView.scrollView setContentOffset:bottomOffset animated:YES];
//        
//
//            }
//        
//        }
//        
    }

   
//    webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// Switch to Home
- (IBAction)button_DoneWasPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
