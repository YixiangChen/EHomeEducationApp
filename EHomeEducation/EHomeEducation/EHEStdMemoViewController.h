//
//  EHEStdMemoViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/25/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHEStdOrderViewController.h"

@interface EHEStdMemoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *txtViewMemo;
@property (strong, nonatomic) EHEStdOrderViewController *orderTable;

@end
