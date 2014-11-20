//
//  EHEBaiduMapView.h
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-20.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHEBaiduMapView : UIView
@property(strong,nonatomic)UIImageView * teacherImageView;
@property(strong,nonatomic)UILabel * labelTeacherName;
@property(strong,nonatomic)UILabel * labelTeacherSubject;
@property(strong,nonatomic)UILabel * labelTeacherRank;
@property(strong,nonatomic)NSNumber * teacherID;
-(id)init;
@end
