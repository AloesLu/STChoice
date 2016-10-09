//
//  AppDelegate.m
//  STChoice
//
//  Created by AloesLu on 16/4/11.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "AppDelegate.h"
#import "MHLoginViewController.h"
#import "MHAdminTabBarViewController.h"
#import "MHStudentTabBarViewController.h"
#import "MHTeacherTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [NSObject changeBaseURLStrToTest:NO];
    self.window.backgroundColor = [UIColor whiteColor];
    MHLoginViewController *root=[[MHLoginViewController alloc]init];
    
//    MHStudentTabBarViewController *root=[[MHStudentTabBarViewController alloc]init];
    
//    MHTeacherTabBarViewController *root=[[MHTeacherTabBarViewController alloc]init];
    
//    MHAdminTabBarViewController *root=[[MHAdminTabBarViewController alloc]init];
    MHBaseNavigationController *nav=[[MHBaseNavigationController alloc]initWithRootViewController:root];
    self.window.rootViewController=nav;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)loginApp:(int)type{
    if(type==1){
        MHAdminTabBarViewController *root=[[MHAdminTabBarViewController alloc]init];
        self.window.rootViewController=root;
    }else if(type==2){
        MHStudentTabBarViewController *root=[[MHStudentTabBarViewController alloc]init];
        self.window.rootViewController=root;
    }else if(type==3){
        MHTeacherTabBarViewController *root=[[MHTeacherTabBarViewController alloc]init];
        self.window.rootViewController=root;
    }
}

- (void)logoutApp:(int)type{
    if(type==1){
    }else if(type==2){
    }else if(type==3){
    }
    MHLoginViewController *root=[[MHLoginViewController alloc]init];
    MHBaseNavigationController *nav=[[MHBaseNavigationController alloc]initWithRootViewController:root];
    self.window.rootViewController=nav;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
