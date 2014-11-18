//
//  EHECoreDataManager.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/18/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface EHECoreDataManager : NSObject
@property (strong, nonatomic) NSPersistentStoreCoordinator* persistentStoreCoordinator;
@property (strong, nonatomic) NSFetchedResultsController *fetchResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(void) updateTeachersInfo:(NSDictionary *) dictionary;

@end
