//
//  EHEStdTimePickerTableViewCell.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/26/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHEStdTimePickerTableViewCell.h"

@implementation EHEStdTimePickerTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.timePicker.datePickerMode = UIDatePickerModeTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
