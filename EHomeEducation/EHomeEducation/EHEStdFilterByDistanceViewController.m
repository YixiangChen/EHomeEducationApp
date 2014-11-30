//
//  EHEStdFilterByDistanceViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/28/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "Defines.h"
#import "EHEStdFilterByDistanceViewController.h"

@interface EHEStdFilterByDistanceViewController ()

@end

@implementation EHEStdFilterByDistanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.searchBtn setTitleColor:kLightGreenForMainColor forState:UIControlStateNormal];
    [self.searchBtn addTarget:self action:@selector(applyFilter) forControlEvents:UIControlEventTouchUpInside];
    
    [self.lblText setTextColor:kLightGreenForMainColor];
    
    
}


-(void) applyFilter {
    [self.popController dismissPopoverAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return  YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
