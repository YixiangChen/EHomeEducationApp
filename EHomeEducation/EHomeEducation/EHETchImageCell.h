//
//  EHETchImageCell.h
//  EHomeEduCustomer
//
//  Created by Yixiang Chen on 12/9/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHETchImageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewTch;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewBG;
@property(strong,nonatomic) UIImageView * imageDistance;
@property (strong, nonatomic) IBOutlet UILabel *lblEvaluation;
@property (strong, nonatomic) IBOutlet UILabel *lblDistance;

@end
