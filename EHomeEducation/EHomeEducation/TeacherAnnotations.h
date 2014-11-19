//
//  TeacherAnnotations.h
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-19.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"
@interface TeacherAnnotations : NSObject<BMKAnnotation>
@property(nonatomic)double teacherLatitude;
@property(nonatomic)double teacherLongtitude;
@property(strong,nonatomic)NSString * teacherName;
@property(strong,nonatomic)NSString * teacherSubject;
@property(strong,nonatomic)NSString * teacherSex;
-(id)initWithlatitude:(double)latitude andLongtitude:(double)longtitude andTeacherName:(NSString *)teacherName andTeacherSubject:(NSString *)teacherSubject andTeacherSex:(NSString *)teacherSex;
@end
