//
//  EHETchRegularCell.h
//  EHomeEduCustomer
//
//  Created by Yixiang Chen on 12/9/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHETeacher.h"
#import "EHETchDetailViewController.h"

@interface EHETchRegularCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblItem;
@property (strong, nonatomic) IBOutlet UILabel *lblItemContent;
@property (strong, nonatomic) EHETchDetailViewController *tchDetailViewController;

-(void)setContent:(EHETeacher *)teacher withRowIndex:(int)index;

@end
