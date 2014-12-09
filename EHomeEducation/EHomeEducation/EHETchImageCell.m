//
//  EHETchImageCell.m
//  EHomeEduCustomer
//
//  Created by Yixiang Chen on 12/9/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "Defines.h"
#import "EHETchImageCell.h"

@implementation EHETchImageCell

- (void)awakeFromNib {
    // Initialization code
    
    self.imageViewTch.layer.cornerRadius = 38.0f;
    self.imageViewTch.clipsToBounds=YES;
    
    [self.lblName setFont:[UIFont fontWithName:kFangZhengKaTongFont size:18]];
    [self.lblEvaluation setFont:[UIFont fontWithName:kFangZhengKaTongFont size:18]];
    [self.lblDistance setFont:[UIFont fontWithName:kFangZhengKaTongFont size:18]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
