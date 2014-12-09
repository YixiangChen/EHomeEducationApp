//
//  EHETchRegularCell.m
//  EHomeEduCustomer
//
//  Created by Yixiang Chen on 12/9/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "Defines.h"
#import "EHETchRegularCell.h"

@implementation EHETchRegularCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setContent:(EHETeacher *)teacher withRowIndex:(int)index {
    [self.lblItem setFont:[UIFont fontWithName:kMengNaFont size:13]];
    [self.lblItem setTextColor:[UIColor lightGrayColor]];
    [self.lblItemContent setFont:[UIFont fontWithName:kMengNaFont size:13]];
    if (index == 1) {
        self.lblItem.text = @"辅导对象";
        self.lblItemContent.text = [NSString stringWithFormat:@"%@  %@", teacher.objectInfo, teacher.subjectInfo];
    }
    if (index == 2) {
        self.lblItem.text = @"学历";
        self.lblItemContent.text = teacher.degree;
    }
    
    if (index == 3) {
        self.lblItem.text = @"住址";
        self.lblItemContent.text = teacher.majorAdress;
    }
    if (index == 4) {
        self.lblItem.text = @"闲暇时间";
        self.lblItemContent.text = teacher.timePeriod;
    }
    if (index == 5) {
        self.lblItem.text = @"电话";
        self.lblItemContent.text = teacher.telephone;
    }
    
    if (index == 6) {
        self.lblItem.text = @"QQ";
        self.lblItemContent.text = teacher.qq;
    }
    
    if (index == 7) {
        self.lblItem.text = @"新浪微博";
        self.lblItemContent.text = teacher.sinaweibo;
    }
    if (index == 8) {
        self.lblItem.text = @"备注";
        self.lblItemContent.text = teacher.memo;
    }
}

@end
