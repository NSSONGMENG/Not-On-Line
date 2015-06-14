//
//  AppDelegate.m
//  PLBWaining
//
//  Created by songmeng on 15/4/1.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarController.h"
#import "Singleton.h"
#import "Define.h"
#import "Reachability.h"
#import "LoginViewController.h"

@interface AppDelegate ()<UIAlertViewDelegate>
@property (nonatomic,strong) Reachability * reach;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //单例初始化
    [Singleton shareSingleton];
    
    #pragma  mark  -------------------网络判断--------------------
    self.reach = [Reachability reachabilityForInternetConnection];
    [self.reach startNotifier]; //开启网络判断
    //通过通知中心监测网络变化
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkStateChange)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [self networkStateChange];
    
    //创建RootTabBarController实例对象
    RootTabBarController * rootTBC = [[RootTabBarController alloc] init];
    //将rootTBC指定为根视图控制器
    self.window.rootViewController = rootTBC;
    
    //创建登录界面实例对象，并以present方式推出
    LoginViewController * loginVC = [[LoginViewController alloc] init];
    [self.window.rootViewController presentViewController:loginVC animated:NO completion:nil];

    
    
    return YES;
}

#pragma  mark  -------------------网络判断--------------------
- (void)networkStateChange{
    switch ([self.reach currentReachabilityStatus]) {
        case NotReachable:{
            [Singleton setNetworkEnable:NO];
            break;
        }
        case ReachableViaWiFi:{
            [Singleton setNetworkEnable:YES];
            break;
        }
        case ReachableViaWWAN:{
            [Singleton setNetworkEnable:YES];
            break;
        }
    }
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
