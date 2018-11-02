//
//  AppDelegate.m
//  BaseProject
//
//  Created by feiwei on 2017/3/3.
//  Copyright © 2017年 feiwei. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LoginViewController.h"

#import <IQKeyboardManager/IQKeyboardManager.h>

@interface AppDelegate ()<btnClickDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /*
     2.判断是否第一次使用这个版本
     */
    NSString *key = (NSString *)kCFBundleVersionKey;
    
    // 2.1.先去沙盒中取出上次使用的版本号
    NSString *lastVersionCode = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    // 2.2.加载程序中info.plist文件(获得当前软件的版本号)
    NSString *currentVersionCode = [NSBundle mainBundle].infoDictionary[key];
    
    if ([lastVersionCode isEqualToString:currentVersionCode]) {
        // 非第一次使用软件
        [self initTabBar];
    }else {
        // 第一次使用软件
        // 2.3.保存当前软件版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersionCode forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ViewController *vc = [[ViewController alloc] init];
        vc.clickDelegate = self;
        self.window.rootViewController = vc;
    }
    //键盘监听的设置
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    return YES;
}
- (void)initTabBar {
    self.window.rootViewController = nil;
    for (UIView *view in self.window.subviews) {
        [view removeFromSuperview];
    }
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    if ([UserDefaults objectForKey:@"tokenContent"] == nil){
//        LoginViewController *homeVC = [[LoginViewController alloc] init];
//        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:homeVC];
        TabBarViewController *homeVC = [[TabBarViewController alloc] init];
        //        [JPUSHService setTags:[NSSet set] aliasInbackground:[UserDefaults objectForKey:@"tokenContent"]];
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:homeVC];
    }else {
//        TabBarViewController *homeVC = [[TabBarViewController alloc] init];
////        [JPUSHService setTags:[NSSet set] aliasInbackground:[UserDefaults objectForKey:@"tokenContent"]];
//        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:homeVC];
    }
}

#pragma mark ---btnClickDelegate
- (void)btnhaveClicked{
    [self initTabBar];
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
