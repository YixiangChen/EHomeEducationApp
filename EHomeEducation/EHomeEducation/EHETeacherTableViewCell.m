//
//  EHETeacherTableViewCell.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/20/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "Defines.h"
#import "EHETeacherTableViewCell.h"
#import "QuartzCore/QuartzCore.h"


@implementation EHETeacherTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.teacherImage.clipsToBounds=YES;
    self.teacherImage.layer.cornerRadius = 38.0f;
    self.teacherImage.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setContent:(EHETeacher*) teacher
{
    self.lblTeacherName.text = teacher.name;
    [self.lblTeacherName setFont:[UIFont fontWithName:@"FZKATJW--GB1-0" size:20]];

    self.lblTeacherRank.text = [NSString stringWithFormat:@"评价：%@",teacher.rank];
    [self.lblTeacherRank setFont:[UIFont fontWithName:@"FZKATJW--GB1-0" size:13]];
    
    self.lblTeacherSubject.text = teacher.subjectInfo;
    [self.lblTeacherSubject setFont:[UIFont fontWithName:@"MYoungHKS" size:14]];
    
}

@end
