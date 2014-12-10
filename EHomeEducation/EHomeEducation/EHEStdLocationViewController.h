//
//  EHEStdLocationViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/25/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHEStdOrderViewController.h"

@interface EHEStdLocationViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) EHEStdOrderViewController *orderTable;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *location;

@end
