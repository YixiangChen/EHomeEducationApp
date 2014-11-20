//
//  EHETeacherTableViewCell.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/20/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHETeacherTableViewCell.h"


@implementation EHETeacherTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setContent:(EHETeacher*) teacher
{
    self.lblTeacherName.text = teacher.name;
    self.lblTeacherRank.text = [NSString stringWithFormat:@"评价：%@",teacher.rank];
    self.lblTeacherSubject.text = teacher.subjectInfo;
    
    UIImage *femaleImage = [UIImage imageNamed:@"female_tablecell.png"];
    UIImage *maleImage = [UIImage imageNamed:@"male_tablecell.png"];
    if ([teacher.gender isEqualToString:@"男"]) {
        self.teacherImage.image = maleImage;
    }else {
        self.teacherImage.image = femaleImage;
    }
}

@end
