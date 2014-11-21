//
//  EHEStdSettingTableViewCell.m
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-21.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHEStdSettingTableViewCell.h"

@implementation EHEStdSettingTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.settingLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 8, 150, 30)];
        self.settingLabel.textColor=[UIColor blackColor];
        self.settingLabel.backgroundColor=[UIColor clearColor];
        self.settingLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:17.0f];//字体设置为加粗
        [self addSubview:self.settingLabel];
        
        self.settingImageView=[[UIImageView alloc]initWithFrame:CGRectMake(230, 8, 30, 30)];
        self.settingImageView.layer.cornerRadius=20;
        [self addSubview:self.settingImageView];
    }
    return self;
}
@end
