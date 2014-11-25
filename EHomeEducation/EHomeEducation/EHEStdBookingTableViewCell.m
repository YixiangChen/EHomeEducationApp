//
//  EHEStdBookingTableViewCell.m
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-21.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHEStdBookingTableViewCell.h"

@implementation EHEStdBookingTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.labelTeacherInfomation=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 250, 30)];
        self.labelTeacherInfomation.textColor=[UIColor blackColor];
        self.labelTeacherInfomation.backgroundColor=[UIColor clearColor];
        self.labelTeacherInfomation.font=[UIFont fontWithName:@"Helvetica-Bold" size:17.0f];//字体设置为加粗
        [self addSubview:self.labelTeacherInfomation];
        
        self.labelDate=[[UILabel alloc]initWithFrame:CGRectMake(200, 15, 150, 30)];
        self.labelDate.textColor=[UIColor blackColor];
        self.labelDate.backgroundColor=[UIColor clearColor];
        self.labelDate.font=[UIFont systemFontOfSize:13.0f];
        [self addSubview:self.labelDate];
    }
    return self;
}
@end
