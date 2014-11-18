//
//  EHECoreDataManager.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/18/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHECoreDataManager.h"
#import "EHETeacher.h"
#import "AppDelegate.h"

@implementation EHECoreDataManager

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

-(id)init
{
    if(self = [super init]){
        id delegate = [UIApplication sharedApplication].delegate;
        self->_context = [delegate valueForKey:@"managedObjectContext"];
    }
    return self;
}

-(void)updateTeachersInfos:(NSDictionary *) dict{
    
    NSArray *dictsForTeacherInfo = dict[@"teachersinfo"];
    NSLog(@"11111111");
    
    for (NSDictionary *dictionary in dictsForTeacherInfo) {
        EHETeacher * teacher = [NSEntityDescription insertNewObjectForEntityForName:@"EHETeacher" inManagedObjectContext:self.context];
        
        teacher.teacherId = dictionary[@"teacherid"];
        teacher.teacherIcon = dictionary[@"teachericon"];
        teacher.subjectInfo = dictionary[@"subjectinfo"];
        teacher.rank = dictionary[@"rank"];
        teacher.name = dictionary[@"name"];
        teacher.majorAdress = dictionary[@"majorAdress"];
        teacher.longitude = dictionary[@"longitude"];
        teacher.latitude = dictionary[@"latitude"];
        NSLog(@"22222");
        [self.context save:nil];
        
    }
    
}

-(NSArray *)fetchAllTeachersInfos {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"EHETeacher"];
    //NSPredicate *newsPredicate = [NSPredicate predicateWithFormat:@"postCategories.slug CONTAINS %@ && postDate <= %@ && postDate >= %@", @"news", beforeDate, afterDate];
    NSPredicate * predicate = nil;
    fetchRequest.predicate = predicate;
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    NSArray *sorts = [[NSArray alloc] initWithObjects:sortByName, nil];
    fetchRequest.sortDescriptors = sorts;
    
    NSError *error;
    NSArray *teachers = [self.context executeFetchRequest:fetchRequest error:&error];
    
    if (error)
    {
        return nil;
    }
    else if (teachers.count > 0)
    {
        return teachers;
    }
    return nil;
}

@end
