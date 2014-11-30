//
//  EHEStdFilterByGenderViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/28/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "Defines.h"
#import "EHEStdFilterByGenderViewController.h"

@interface EHEStdFilterByGenderViewController ()

@end

@implementation EHEStdFilterByGenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.searchBtn setTitleColor:kLightGreenForMainColor forState:UIControlStateNormal];
    [self.searchBtn addTarget:self action:@selector(applyFilter) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view from its nib.
    [self.maleBtn setTitle:@" " forState:UIControlStateNormal];
    [self.maleBtn addTarget:self action:@selector(maleBtnStateChanged) forControlEvents:UIControlEventTouchUpInside];
    //[self.maleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UICon];
    CALayer * maleBtnLayer =  [self.maleBtn layer];
    [maleBtnLayer setMasksToBounds:YES];
    [maleBtnLayer setCornerRadius:10.0];
    [maleBtnLayer setBorderWidth:2.0];
    [maleBtnLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [self.femaleBtn setTitle:@" " forState:UIControlStateNormal];
    [self.femaleBtn addTarget:self action:@selector(femaleBtnStateChanged) forControlEvents:UIControlEventTouchUpInside];
    CALayer * femaleBtnLayer =  [self.femaleBtn layer];
    [femaleBtnLayer setMasksToBounds:YES];
    [femaleBtnLayer setCornerRadius:10.0];
    [femaleBtnLayer setBorderWidth:2.0];
    [femaleBtnLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [self.allManBtn setTitle:@" " forState:UIControlStateNormal];
    [self.allManBtn addTarget:self action:@selector(allManBtnStateChanged) forControlEvents:UIControlEventTouchUpInside];
    CALayer * allManBtnLayer =  [self.allManBtn layer];
    [allManBtnLayer setMasksToBounds:YES];
    [allManBtnLayer setCornerRadius:10.0];
    [allManBtnLayer setBorderWidth:2.0];
    [allManBtnLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
}

-(void) maleBtnStateChanged {
    self.isMaleBtnSelected = !self.isMaleBtnSelected;
    if (self.isMaleBtnSelected) {
        [self.maleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
        self.isFemaleBtnSelected = NO;
        self.isAllManBtnSelected = NO;
        [self.femaleBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [self.allManBtn setBackgroundImage:nil forState:UIControlStateNormal];
        
    } else {
        [self.maleBtn setBackgroundImage:nil forState:UIControlStateNormal];
    }
    
}

-(void) femaleBtnStateChanged {
    self.isFemaleBtnSelected = !self.isFemaleBtnSelected;
    if (self.isFemaleBtnSelected ) {
        [self.femaleBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
        self.isMaleBtnSelected = NO;
        self.isAllManBtnSelected = NO;
        [self.maleBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [self.allManBtn setBackgroundImage:nil forState:UIControlStateNormal];
    } else {
        [self.femaleBtn setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void) allManBtnStateChanged {
    self.isAllManBtnSelected = !self.isAllManBtnSelected;
    if (self.isAllManBtnSelected ) {
        [self.allManBtn setBackgroundImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
        
        self.isFemaleBtnSelected = NO;
        self.isMaleBtnSelected = NO;
        [self.maleBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [self.femaleBtn setBackgroundImage:nil forState:UIControlStateNormal];
    } else {
        [self.allManBtn setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void) applyFilter {
    [self.popController dismissPopoverAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
