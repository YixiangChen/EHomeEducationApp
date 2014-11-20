//
//  EHEBaiduMapView.m
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-20.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHEBaiduMapView.h"

@implementation EHEBaiduMapView
-(id)init
{
    if(self=[super init])
    {
        self->_teacherImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 50, 50)];
        self->_teacherImageView.alpha=1.0f;
        
        self.labelTeacherName=[[UILabel alloc]initWithFrame:CGRectMake(55,0, 150, 25)];
        self.labelTeacherName.textColor=[UIColor whiteColor];
        self.labelTeacherName.backgroundColor=[UIColor clearColor];
        self.labelTeacherName.font=[UIFont systemFontOfSize:12.0f];
        self.labelTeacherName.alpha=1.0f;
        
        self.labelTeacherSubject=[[UILabel alloc]initWithFrame:CGRectMake(55, 22, 150, 25)];
        self.labelTeacherSubject.textColor=[UIColor whiteColor];
        self.labelTeacherSubject.backgroundColor=[UIColor clearColor];
        self.labelTeacherSubject.font=[UIFont systemFontOfSize:12.0f];
        self.labelTeacherSubject.alpha=1.0f;
        
        self.labelTeacherRank=[[UILabel alloc]initWithFrame:CGRectMake(55, 45, 183, 25)];
        self.labelTeacherRank.textColor=[UIColor whiteColor];
        self.labelTeacherRank.backgroundColor=[UIColor clearColor];
        self.labelTeacherRank.font=[UIFont systemFontOfSize:12.0f];
        self.labelTeacherRank.alpha=1.0f;

    }
    [self addSubview:self->_teacherImageView];
    [self addSubview:self->_labelTeacherName];
    [self addSubview:self->_labelTeacherSubject];
    [self addSubview:self->_labelTeacherRank];
    
    return self;
}

@end