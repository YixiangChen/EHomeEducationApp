//
//  EHEStdCommentCell.m
//  EHomeEducation
//
//  Created by MacBook Pro on 14-12-2.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHEStdCommentCell.h"

@implementation EHEStdCommentCell

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
        self.commentLabel=[[UILabel alloc]initWithFrame:CGRectMake(8, 8, 300, 100)];
        self.commentLabel.textColor=[UIColor blackColor];
        self.commentLabel.backgroundColor=[UIColor clearColor];
        self.commentLabel.font=[UIFont systemFontOfSize:15.0f];
        [self addSubview:self.commentLabel];
        
        self.dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(8, self.commentLabel.frame.size.height+5, 100, 30)];
        self.dateLabel.textColor=[UIColor grayColor];
        self.dateLabel.backgroundColor=[UIColor clearColor];
        self.dateLabel.font=[UIFont systemFontOfSize:13.0f];
        [self addSubview:self.dateLabel];
    }
    return self;
}

@end
