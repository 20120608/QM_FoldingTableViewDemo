//
//  AppDelegate.m
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"                   //弹出的键盘高度控制
#import "DQMFoldingTableViewController.h"       //折叠的列表
#import "DQMNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  /*配置键盘*/
  IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
  manager.enable = YES;//    控制整个功能是否启用。
  manager.overrideKeyboardAppearance = YES;
  manager.shouldResignOnTouchOutside = YES;//控制点击背景是否收起键盘
  manager.enableAutoToolbar = YES;//控制是否显示键盘上的工具条。
  manager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
  
  DQMFoldingTableViewController *vc = [[DQMFoldingTableViewController alloc] initWithTitle:@"可折叠列表"];
  DQMNavigationController *navi = [[DQMNavigationController alloc] initWithRootViewController:vc];
  self.window.rootViewController = navi;
  
  
  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
