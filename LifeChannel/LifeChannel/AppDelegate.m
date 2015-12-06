//
//  AppDelegate.m
//  LifeChannel
//
//  Created by 白金星 on 15/12/2.
//  Copyright © 2015年 cn.bjx680. All rights reserved.
//

#import "AppDelegate.h"
#import "JXHomeViewController.h"
#import "JXHomePageViewController.h"
#import "JXGuideViewController.h"
#import "JXHotSpotViewController.h"
#import "JXLoginViewController.h"
#import "JXOnLineViewController.h"
#import "JXUserCenterViewController.h"
#import "JXCircleViewController.h"
#import "JXToolsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//本地通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
       NSLog(@"didReceiveLocalNotification");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //显示
    [self.window makeKeyAndVisible];

    //监听通知
//    [NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterMainPage) name:<#(nullable NSString *)#> object:<#(nullable id)#>

    [self  enterMainPage];


    return YES;
}

//进入控制器
- (void)enterMainPage{

    //获取storyboard
    UIStoryboard *storyB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //获取控制器
    NSArray *tabbarArr =@[@"JXHomeViewController",@"JXHotSpotViewController",@"JXCircleViewController",@"JXToolsViewController",@"JXHomePageViewController",@"JXOnLineViewController"];
    //存放tabbar的子控制器
    NSMutableArray *tabbarArrM = [NSMutableArray array];
     //遍历
    for (NSString *NameVc in tabbarArr) {
        UIViewController *vc = [storyB instantiateViewControllerWithIdentifier:NameVc];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [tabbarArrM addObject:nav];

    }
    //让TabBarController拿到所有的控制器,实例化
    self.tab = [[JXTabBarController alloc]init];
    self.tab.viewControllers = tabbarArrM;

      //根控制器
    self.window.rootViewController = _tab;




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
