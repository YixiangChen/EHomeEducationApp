//
//  AppDelegate.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/17/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "AppDelegate.h"
#import "EHECommunicationManager.h"
#import "EHEStdSearchingTableViewController.h"
#import "EHEStdMapSearchingViewController.h"
#import "EHEStdBookingManagerViewController.h"
#import "EHEStdSettingViewController.h"
#import "EHEStdLoginViewController.h"

#import <ShareSDK/ShareSDK.h>
#import "WeiboApi.h"
#import "WeiboSDK.h"
#import <QQConnection/QQConnection.h>
#import "WXApi.h"
#import <RennSDK/RennSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"passWord"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[EHECoreDataManager getInstance] deleteData];
    [[EHECommunicationManager getInstance]loadTeachersInfo];
    [NSThread sleepForTimeInterval:2];
    
    UIBarButtonItem *appearance = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor yellowColor] forKey:NSForegroundColorAttributeName] forState:1];
    [ShareSDK registerApp:@"45c7af441ad8"]; //注册分享信息
    
    EHEStdSearchingTableViewController *searchingTable =[[EHEStdSearchingTableViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navi_searching = [[UINavigationController alloc] initWithRootViewController:searchingTable];
    //navi_searching.navigationBarHidden=YES;
    
    EHEStdMapSearchingViewController * mapViewController=[[EHEStdMapSearchingViewController alloc]initWithNibName:nil bundle:nil];
    UINavigationController * navi_mapSearching=[[UINavigationController alloc]initWithRootViewController:mapViewController];
    navi_mapSearching.navigationBarHidden=YES;


    EHEStdBookingManagerViewController *bookingManager = [[EHEStdBookingManagerViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController * navi_bookingManager=[[UINavigationController alloc]initWithRootViewController:bookingManager];
    EHEStdSettingViewController *setting = [[EHEStdSettingViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController * navi_setting=[[UINavigationController alloc]initWithRootViewController:setting];

    
    UITabBarController *tab = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    //tab.viewControllers = @[navi_searching,bookingManager, setting];
    tab.viewControllers = @[navi_searching,navi_bookingManager, navi_setting];
    [[tab.viewControllers objectAtIndex:0] setTitle:@"首页"];
    [[tab.viewControllers objectAtIndex:1] setTitle:@"我的"];
    [[tab.viewControllers objectAtIndex:2] setTitle:@"设置"];
    tab.tabBar.backgroundColor = [UIColor grayColor];
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"XfRTzKUzfDjbBIKC55iY2Wa1"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

        EHEStdSearchingTableViewController *searchingTable =[[EHEStdSearchingTableViewController alloc] initWithNibName:nil bundle:nil];
        UINavigationController *navi_searching = [[UINavigationController alloc] initWithRootViewController:searchingTable];
        
        EHEStdMapSearchingViewController * mapViewController=[[EHEStdMapSearchingViewController alloc]initWithNibName:nil bundle:nil];
        UINavigationController * navi_mapSearching=[[UINavigationController alloc]initWithRootViewController:mapViewController];
        navi_mapSearching.navigationBarHidden=YES;
        
        
        EHEStdBookingManagerViewController *bookingManager = [[EHEStdBookingManagerViewController alloc] initWithNibName:nil bundle:nil];
        EHEStdSettingViewController *setting = [[EHEStdSettingViewController alloc] initWithNibName:nil bundle:nil];
        
        UITabBarController *tab = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
        //tab.viewControllers = @[navi_searching,bookingManager, setting];
        tab.viewControllers = @[navi_searching,bookingManager, setting];
        [[tab.viewControllers objectAtIndex:0] setTitle:@"首页"];
        [[tab.viewControllers objectAtIndex:1] setTitle:@"我的"];
        [[tab.viewControllers objectAtIndex:2] setTitle:@"设置"];
        tab.tabBar.backgroundColor = [UIColor grayColor];
        
        self.window.rootViewController = tab;
    
    self.window.rootViewController = tab;
    
    //初始化分享平台
    [self initPlat];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
-(void)initPlat
{
    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"];
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:@"568898243"
                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                              redirectUri:@"http://www.sharesdk.cn"
                              weiboSDKCls:[WeiboSDK class]];
    
    //添加腾讯微博应用 注册网址 http://dev.t.qq.com
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"
                                   wbApiCls:[WeiboApi class]];
    
    [ShareSDK importTencentWeiboClass:[WeiboApi class]];
    
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    [ShareSDK importQQClass:[QQApiInterface class]
            tencentOAuthCls:[TencentOAuth class]];
    
    
    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
                           wechatCls:[WXApi class]];
    
    //添加网易微博应用 注册网址  http://open.t.163.com
    [ShareSDK connect163WeiboWithAppKey:@"T5EI7BXe13vfyDuy"
                              appSecret:@"gZxwyNOvjFYpxwwlnuizHRRtBRZ2lV1j"
                            redirectUri:@"http://www.shareSDK.cn"];
    
    //添加搜狐微博应用  注册网址  http://open.t.sohu.com
    [ShareSDK connectSohuWeiboWithConsumerKey:@"SAfmTG1blxZY3HztESWx"
                               consumerSecret:@"yfTZf)!rVwh*3dqQuVJVsUL37!F)!yS9S!Orcsij"
                                  redirectUri:@"http://www.sharesdk.cn"];
    
    //添加豆瓣应用  注册网址 http://developers.douban.com
    [ShareSDK connectDoubanWithAppKey:@"07d08fbfc1210e931771af3f43632bb9"
                            appSecret:@"e32896161e72be91"
                          redirectUri:@"http://dev.kumoway.com/braininference/infos.php"];
    
    //添加人人网应用 注册网址  http://dev.renren.com
    [ShareSDK connectRenRenWithAppId:@"226427"
                              appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                           appSecret:@"f29df781abdd4f49beca5a2194676ca4"
                   renrenClientClass:[RennClient class]];
    
    [ShareSDK importRenRenClass:[RennClient class]];
    
    //添加开心网应用  注册网址 http://open.kaixin001.com
    [ShareSDK connectKaiXinWithAppKey:@"358443394194887cee81ff5890870c7c"
                            appSecret:@"da32179d859c016169f66d90b6db2a23"
                          redirectUri:@"http://www.sharesdk.cn/"];
    
    //添加Instapaper应用   注册网址  http://www.instapaper.com/main/request_oauth_consumer_token
    [ShareSDK connectInstapaperWithAppKey:@"4rDJORmcOcSAZL1YpqGHRI605xUvrLbOhkJ07yO0wWrYrc61FA"
                                appSecret:@"GNr1GespOQbrm8nvd7rlUsyRQsIo3boIbMguAl9gfpdL0aKZWe"];
    
    //添加有道云笔记应用  注册网址 http://note.youdao.com/open/developguide.html#app
    [ShareSDK connectYouDaoNoteWithConsumerKey:@"dcde25dca105bcc36884ed4534dab940"
                                consumerSecret:@"d98217b4020e7f1874263795f44838fe"
                                   redirectUri:@"http://www.sharesdk.cn/"];
    
    //添加Facebook应用  注册网址 https://developers.facebook.com
    [ShareSDK connectFacebookWithAppKey:@"107704292745179"
                              appSecret:@"38053202e1a5fe26c80c753071f0b573"];
    
    //添加Twitter应用  注册网址  https://dev.twitter.com
    [ShareSDK connectTwitterWithConsumerKey:@"mnTGqtXk0TYMXYTN7qUxg"
                             consumerSecret:@"ROkFqr8c3m1HXqS3rm3TJ0WkAJuwBOSaWhPbZ9Ojuc"
                                redirectUri:@"http://www.sharesdk.cn"];
    
    //添加搜狐随身看应用 注册网址  https://open.sohu.com
    [ShareSDK connectSohuKanWithAppKey:@"e16680a815134504b746c86e08a19db0"
                             appSecret:@"b8eec53707c3976efc91614dd16ef81c"
                           redirectUri:@"http://sharesdk.cn"];
    
    //添加Pocket应用  注册网址  http://getpocket.com/developer/
    [ShareSDK connectPocketWithConsumerKey:@"11496-de7c8c5eb25b2c9fcdc2b627"
                               redirectUri:@"pocketapp1234"];
    
    //添加印象笔记应用   注册网址  http://dev.yinxiang.com
    [ShareSDK connectEvernoteWithType:SSEverNoteTypeSandbox
                          consumerKey:@"sharesdk-7807"
                       consumerSecret:@"d05bf86993836004"];
    
    //添加LinkedIn应用  注册网址 https://www.linkedin.com/secure/developer
    [ShareSDK connectLinkedInWithApiKey:@"ejo5ibkye3vo"
                              secretKey:@"cC7B2jpxITqPLZ5M"
                            redirectUri:@"http://sharesdk.cn"];
}
//处理微信delegate
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}
//微信delegate平台
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "appchen.EHomeEducation" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"EHomeEducation" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"EHomeEducation.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
