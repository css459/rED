//
//  AppDelegate.m
//  rED
//
//  Created by Cole Smith on 2/3/15.
//  Copyright (c) 2015 Shorecrest Preparatory. All rights reserved.
//

#import "AppDelegate.h"
#import "Settings.h"
#import "Notebook.h"

@interface AppDelegate ()
{
    NSString *archivePath;
}
@end

@implementation AppDelegate

+(void)downloadDataFromURL:(NSURL *)url withCompletionHandler:(void (^)(NSData *))completionHandler {
    // Instantiate a session configuration object.
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Instantiate a session object.
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    // Create a data task to perform the data downloading.
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      if (error != nil) {
                                          // If any error occurs then just display its description on the console.
                                          NSLog(@"%@", [error localizedDescription]);
                                      } else {
                                          // If no error occurs, check the HTTP status code.
                                          NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
                                          
                                          // If it's other than 200, then show it on the console.
                                          if (HTTPStatusCode != 200) {
//                                              NSLog(@"HTTP status code = %ld", (long)HTTPStatusCode);
                                          }
                                          
                                          // Call the completion handler with the returned data on the main thread.
                                          [[NSOperationQueue mainQueue] addOperationWithBlock:^
                                           {
                                               completionHandler(data);
                                           }];
                                      }
                                  }];
    
    // Resume the task.
    [task resume];
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSString *urlParameter = [[url host] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"URL PARAMETER: %@", urlParameter);
    
    if (url){
        NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"The file contained: %@",str);
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    Settings *sharedSettings = [Settings sharedSettings];
    Notebook *sharedNotebook = [Notebook sharedNotebook];
    
    NSLog(@"Settings for save: %@", sharedSettings);
    NSLog(@"Notebook for save: %@", sharedNotebook);
    
    NSArray *array_wrapperForSave = @[sharedSettings, sharedNotebook];
    
    NSArray *archiveDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *archivePathForArray = [archiveDirectory objectAtIndex:0];
    NSString *directoryForArray = [archivePathForArray stringByAppendingPathComponent:@"UserDataBundle.archive"];
    archivePath = directoryForArray;
    
    BOOL success = [NSKeyedArchiver archiveRootObject:array_wrapperForSave toFile:archivePath];
    
    NSLog(@"Data Archive Status: %d", success);
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
