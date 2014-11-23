//
//  EHECommunicationManager.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/18/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHECommunicationManager : NSObject

+ (EHECommunicationManager *) getInstance;
-(void)loadTeachersInfo;
-(void)loadDataWithTeacherID:(int) teacherId;
-(void)sendOrder:(NSDictionary *) dictOrder;

@end
