//
//  TeacherAnnotations.m
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-19.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "TeacherAnnotations.h"

@implementation TeacherAnnotations
-(id)initWithlatitude:(double)latitude andLongtitude:(double)longtitude andTeacherName:(NSString *)teacherName andTeacherSubject:(NSString *)teacherSubject andTeacherSex:(NSString *)teacherSex
{
  if(self=[super init])
  {
      self->_teacherLatitude=latitude;
      self->_teacherLongtitude=longtitude;
      self->_teacherName=teacherName;
      self->_teacherSubject=teacherSubject;
      self->_teacherSex=teacherSex;
  }
    return  self;
}
@end
