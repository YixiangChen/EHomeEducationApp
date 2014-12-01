//
//  AppDelegate.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/17/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "BMKMapManager.h"
//这是一个测试的注释

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>
{
  BMKMapManager * _mapManager;
}
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic)BOOL check;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UITabBarController *tab;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

