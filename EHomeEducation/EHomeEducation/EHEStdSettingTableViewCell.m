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
        
        self.settingImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 50, 50)];
        self.settingImageView.layer.cornerRadius=20;
        [self addSubview:self.settingImageView];
        
        self.contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(130, 8, 150, 30)];
        self.contentLabel.textAlignment=UITextAlignmentRight;
        self.contentLabel.textColor=[UIColor grayColor];
        self.contentLabel.backgroundColor=[UIColor clearColor];
        self.contentLabel.font=[UIFont systemFontOfSize:15.0f];
        [self addSubview:self.contentLabel];
        
        self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 18, 100, 30)];
        self.nameLabel.textColor=[UIColor blackColor];
        self.nameLabel.backgroundColor=[UIColor clearColor];
        self.nameLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
        [self addSubview:self.nameLabel];
        
        self.iconLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 100, 30)];
        self.iconLabel.textColor=[UIColor blackColor];
        self.iconLabel.backgroundColor=[UIColor clearColor];
        self.iconLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
        [self addSubview:self.iconLabel];
        
        self.imageIcon=[[UIImageView alloc]initWithFrame:CGRectMake(240, 10, 50, 50)];
        self.imageIcon.layer.cornerRadius=20.0f;
        [self addSubview:self.imageIcon];
        
    }
    return self;
}
@end
