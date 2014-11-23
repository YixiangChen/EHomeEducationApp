//
//  EHEStdSettingDetailCell.m
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-22.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHEStdSettingDetailCell.h"

@implementation EHEStdSettingDetailCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.detailTextsLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 8, 100, 30)];
        self.detailTextsLabel.textColor=[UIColor blackColor];
        self.detailTextsLabel.backgroundColor=[UIColor clearColor];
        self.detailTextsLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:17.0f];//字体设置为加粗
        [self addSubview:self.detailTextsLabel];
        
        self.detailTextField=[[UITextField alloc]initWithFrame:CGRectMake(80, 2, 180, 40)];
        self.detailTextField.borderStyle=UITextBorderStyleNone;
        [self addSubview:self.detailTextField];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.detailTextField resignFirstResponder];
//}
@end
