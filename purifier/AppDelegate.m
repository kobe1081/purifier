//
//  AppDelegate.m
//  purifier
//
//  Created by Tony on 15/11/24.
//  Copyright © 2015年 iMac. All rights reserved.
//

#import "AppDelegate.h"
#import "MobClick.h"
#import "IQKeyboardManager.h"
#import "LeftController.h"
#import "DDMenuController.h"
#import "CustomNavigationController.h"
#import "MainPageVC.h"
#import "HeStartPairVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initialization];
    [self umengTrack];
    return YES;
}

- (void)initialization
{
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    [[UINavigationBar appearance] setTintColor:NAVTINTCOLOR];
    UIImage *navBackgroundImage = [UIImage imageNamed:@"NavBarIOS7"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
//    MainPageVC *mainController = [[MainPageVC alloc] initWithNibName:nil bundle:nil];
    
    HeStartPairVC *startPairVC = [[HeStartPairVC alloc] initWithNibName:nil bundle:nil];
    CustomNavigationController *navController = [[CustomNavigationController alloc] initWithRootViewController:startPairVC];
    
//    DDMenuController *rootController = [[DDMenuController alloc] initWithRootViewController:navController];
//    _menuController = rootController;
//    
//    LeftController *leftController = [[LeftController alloc] init];
//    rootController.leftViewController = leftController;
    
    
    

    self.window.rootViewController = navController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
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


//初始化友盟的SDK
- (void)umengTrack
{
    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick startWithAppkey:UMANALYSISKEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    [MobClick setCrashReportEnabled:YES]; // 如果不需要捕捉异常，注释掉此行
    [MobClick setBackgroundTaskEnabled:YES];
    [MobClick setLogSendInterval:3600];//每隔两小时上传一次
    [MobClick updateOnlineConfig];  //在线参数配置
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}

- (void)networkDidSetup:(NSNotification *)notification {
    
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    
    NSLog(@"未连接。。。");
}

- (void)networkDidRegister:(NSNotification *)notification {
    
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    
    NSLog(@"已登录");
}

@end
