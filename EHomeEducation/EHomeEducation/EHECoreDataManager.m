//
//  EHECoreDataManager.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/18/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHECoreDataManager.h"

@implementation EHECoreDataManager
#pragma mark singleton

+ (EHECoreDataManager *) getInstance
{
    static EHECoreDataManager *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
        {
            sharedSingleton = [[EHECoreDataManager alloc] init];
        }
        
        return sharedSingleton;
    }
}

#pragma mark init

//- (id)init
//{
//    self = [super init];
//    if (self)
//    {
//        [self initEHECoreData];
//    }
//    return self;
//}

//-(void)initCoreData
//{
//    NSError *error;
//    //Path to sqlite file.
//    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/exklusiv_muenchen.sqlite"];
//    NSURL *url = [NSURL fileURLWithPath:path];
//
//    //init the model
//    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
//
//    //Establish the persistent store coordinator
//    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
//
//    if(![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error])
//    {
//        ALog(@"Error %@",[error localizedDescription]);
//
//    }
//    else
//    {
//        self.managedObjectContext = [[NSManagedObjectContext alloc ] init ];
//        self.managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
//
//        //     self.importContext = [[NSManagedObjectContext alloc] init];
//        //     self.importContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
//    }
//
//}

-(void)updateTeachersInfo:(NSDictionary *)dictionary {
    [self.managedObjectContext save:nil];
}

@end
