//
//  SASAppDelegate.m
//  SASrpc
//
//  Created by Akash Bhatnagar on 4/18/14.
//  Copyright (c) 2014 Sungard Availability Services. All rights reserved.
//

#import "SASAppDelegate.h"
#import "SASRecoveryEventTableViewController.h"
#import "SASMachineTableViewController.h"

@implementation SASAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //UIImageView *splash = [[UIImageView alloc] initWithFrame:self.window.frame];
    //UIImage* logoImage = [UIImage imageNamed:@"logo.png"];
    //[splash setImage:logoImage];
    
    //[self.window addSubview:splash];
    
    //make the window visible
    //[self.window makeKeyAndVisible];
    
    //sleep(5);
    
    //create event view
    SASRecoveryEventTableViewController *rvc = [[SASRecoveryEventTableViewController alloc] init];
    UINavigationController *eventNavController = [[UINavigationController alloc] initWithRootViewController:rvc];
    
    //create machine view
    SASMachineTableViewController *mvc = [[SASMachineTableViewController alloc] init];
    UINavigationController *machineNavController = [[UINavigationController alloc] initWithRootViewController:mvc];
    
    
    //add the navigation controllers to tab bar
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[eventNavController,machineNavController];
    
    //add machine tab bar item
    machineNavController.tabBarItem.title = @"Machines";
    UIImage *machineImage = [UIImage imageNamed:@"server-25.png"];
    machineNavController.tabBarItem.image = machineImage;
    
    //add event tab bar item
    eventNavController.tabBarItem.title = @"Events";
    UIImage *eventImage = [UIImage imageNamed:@"fires-25.png"];
    eventNavController.tabBarItem.image = eventImage;

    
    //tabBarController.viewControllers = @[machineNavController,eventNavController];
    
    
    //[splash removeFromSuperview];
    self.window.rootViewController = tabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
