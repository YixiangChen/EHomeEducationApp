//
//  EHETeacher.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/18/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EHETeacher : NSManagedObject

@property (nonatomic, retain) NSString * subjectInfo;
@property (nonatomic, retain) NSNumber * teacherId;
@property (nonatomic, retain) NSNumber * rank;
@property (nonatomic, retain) NSString * teacherIcon;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * majorAdress;

@end
