//
//  EHETchDetailViewController.h
//  EHomeEduCustomer
//
//  Created by Yixiang Chen on 12/9/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHETeacher.h"

@interface EHETchDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) EHETeacher *teacher;
@property (strong, nonatomic) NSString *distance;

@end
