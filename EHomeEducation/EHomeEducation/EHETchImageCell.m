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
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if(screenWidth==320&&screenHeight==480)
    {
        self.imageViewBG=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 145)];
        self.imageViewTch=[[UIImageView alloc]initWithFrame:CGRectMake(125,27, 70, 70)];
        self.lblName=[[UILabel alloc]initWithFrame:CGRectMake(134, 110, 212, 21)];
        self.lblEvaluation=[[UILabel alloc]initWithFrame:CGRectMake(231, 110, 122, 21)];
        self.lblDistance=[[UILabel alloc]initWithFrame:CGRectMake(38, 110, 104, 21)];
        self.imageDistance=[[UIImageView alloc]initWithFrame:CGRectMake(11, 108, 25, 25)];
    }
    else if(screenWidth==320&&screenHeight==568)
    {
        self.imageViewBG=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 145)];
        self.imageViewTch=[[UIImageView alloc]initWithFrame:CGRectMake(125,27, 70, 70)];
        self.lblName=[[UILabel alloc]initWithFrame:CGRectMake(134, 110, 212, 21)];
        self.lblEvaluation=[[UILabel alloc]initWithFrame:CGRectMake(231, 110, 122, 21)];
        self.lblDistance=[[UILabel alloc]initWithFrame:CGRectMake(38, 110, 104, 21)];
        self.imageDistance=[[UIImageView alloc]initWithFrame:CGRectMake(11, 108, 25, 25)];
    }
    else if(screenWidth==375&&screenHeight==667)
    {
        self.imageViewBG=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 145)];
        self.imageViewTch=[[UIImageView alloc]initWithFrame:CGRectMake(150,27, 70, 70)];
        self.lblName=[[UILabel alloc]initWithFrame:CGRectMake(160, 110, 212, 21)];
        self.lblEvaluation=[[UILabel alloc]initWithFrame:CGRectMake(261, 110, 122, 21)];
        self.lblDistance=[[UILabel alloc]initWithFrame:CGRectMake(38, 110, 104, 21)];
        self.imageDistance=[[UIImageView alloc]initWithFrame:CGRectMake(11, 108, 25, 25)];
    }
    else if(screenWidth==414&&screenHeight==736)
    {
        self.imageViewBG=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 414, 145)];
        self.imageViewTch=[[UIImageView alloc]initWithFrame:CGRectMake(175,27, 70, 70)];
        self.lblName=[[UILabel alloc]initWithFrame:CGRectMake(164, 110, 212, 21)];
        self.lblEvaluation=[[UILabel alloc]initWithFrame:CGRectMake(261, 110, 122, 21)];
        self.lblDistance=[[UILabel alloc]initWithFrame:CGRectMake(68, 110, 104, 21)];
        self.imageDistance=[[UIImageView alloc]initWithFrame:CGRectMake(41, 108, 25, 25)];
    }
    self.imageViewBG.image=[UIImage imageNamed:@"lightgreen.png"];
    self.imageViewTch.image=[UIImage imageNamed:@"male_tablecell.png"];
    [self addSubview:self.imageViewBG];
    [self addSubview:self.imageViewTch];
    [self.lblName setFont:[UIFont fontWithName:kFangZhengKaTongFont size:18]];
    self.lblName.backgroundColor=[UIColor clearColor];
    [self addSubview:self.lblName];
    
    self.lblEvaluation.backgroundColor=[UIColor clearColor];
    self.lblDistance.backgroundColor=[UIColor clearColor];
    
    [self.lblEvaluation setFont:[UIFont fontWithName:kFangZhengKaTongFont size:18]];
    [self.lblDistance setFont:[UIFont fontWithName:kFangZhengKaTongFont size:18]];
    
    self.imageDistance.image=[UIImage imageNamed:@"distanceIcon.png"];
    [self addSubview:self.lblEvaluation];
    [self addSubview:self.lblDistance];
    [self addSubview:self.imageDistance];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
