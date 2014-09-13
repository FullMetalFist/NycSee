//
//  AppDelegate.m
//  NycSee
//
//  Created by Michael Vilabrera on 7/24/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "AppDelegate.h"

#import "Controller/MapViewController.h"
#import "Controller/SettingsViewController.h"
#import "Controller/XMLTableViewController.h"

@interface AppDelegate()

@property (nonatomic, strong) MapViewController *mapVC;
@property (nonatomic, strong) XMLTableViewController *xmlVC;
@property (nonatomic, strong) SettingsViewController *settingsVC;
@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /* create major view controllers:
     1: Tab bar controller          (map/outages)           no file             tabBarController
     2: Map controller              (map data)                                  mapVC
     3: Navigation controller       (outages -> detail)     no file             navController
     4: TableView controller        (outages)                                   xmlVC
     5: Vanilla View Controller     (detail)                init in TableView   detailVC
     6: Vanilla View Controller     (settings)                                  settingsVC  */
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.mapVC = [[MapViewController alloc] initWithNibName:nil bundle:nil];
    self.xmlVC = [[XMLTableViewController alloc] initWithNibName:nil bundle:nil];
    //self.settingsVC = [[SettingsViewController alloc] initWithNibName:nil bundle:nil];
    self.tabBarController = [[UITabBarController alloc] init];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.xmlVC];
    self.navController.title = @"Outages";
    self.navController.tabBarItem.image = [UIImage imageNamed:@"Outages"];
    self.mapVC.tabBarItem.image = [UIImage imageNamed:@"Map"];
    self.window.rootViewController = self.tabBarController;
    
    [self.tabBarController setViewControllers:@[self.mapVC, self.navController]];

    //[self.tabBarController setViewControllers:@[self.mapVC, self.navController, self.settingsVC]];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
