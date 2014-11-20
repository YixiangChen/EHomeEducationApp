//
//  EHETeacherTableViewCell.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/20/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHETeacher.h"

@interface EHETeacherTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *teacherImage;
@property (strong, nonatomic) IBOutlet UILabel *lblTeacherName;
@property (strong, nonatomic) IBOutlet UILabel *lblTeacherRank;
@property (strong, nonatomic) IBOutlet UILabel *lblTeacherSubject;

-(void)setContent:(EHETeacher*) teacher;

@end
