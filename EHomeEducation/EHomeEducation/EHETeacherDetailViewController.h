//
//  EHETeacherDetailViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/20/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHETeacher.h"

@interface EHETeacherDetailViewController : UIViewController<UITabBarControllerDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *HeaderView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblRank;
@property (strong, nonatomic) IBOutlet UILabel *lblGender;
@property (strong, nonatomic) IBOutlet UILabel *lblAge;
@property (strong, nonatomic) IBOutlet UIButton *btnBook;
@property (strong, nonatomic) IBOutlet UIButton *btnCall;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIImageView *teacherImage;
@property (strong, nonatomic) EHETeacher *teacher;


- (IBAction)callButtonPressed:(id)sender;

- (IBAction)bookButtonPressed:(id)sender;


@end
