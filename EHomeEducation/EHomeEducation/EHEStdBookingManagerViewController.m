//
//  EHEStdBookingManagerViewController.m
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-18.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHEStdBookingManagerViewController.h"

@interface EHEStdBookingManagerViewController ()

@end

@implementation EHEStdBookingManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.segmentedControl =[[EHESegmentedControlManager alloc]initWithItems:[NSArray arrayWithObjects:@"未完成预约",@"已完成预约", nil]];
    [self.segmentedControl addTarget:self action:@selector(selectedSegmentChanged:)forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentedControl;
    
    self.arrayTeacherInfo=[[NSArray alloc]initWithObjects:@"家教信息1(未完成)",@"家教信息2(未完成)",@"家教信息3(未完成)",@"家教信息4(未完成)", nil];
    self.arrayDate=[[NSArray alloc]initWithObjects:@"2014-02-14",@"2014-02-14",@"2014-02-14",@"2014-02-14", nil];
    
    self.homeTeacherTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.homeTeacherTableView.dataSource=self;
    self.homeTeacherTableView.delegate=self;
    self.homeTeacherTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.homeTeacherTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) selectedSegmentChanged:(UISegmentedControl *) seg {
    if(seg.selectedSegmentIndex==0)
    {
        self.arrayTeacherInfo=nil;
        self.arrayTeacherInfo=[[NSArray alloc]initWithObjects:@"家教信息1(未完成)",@"家教信息2(未完成)",@"家教信息3(未完成)",@"家教信息4(未完成)", nil];
        [self.homeTeacherTableView reloadData];
    }
    else
    {
        self.arrayTeacherInfo=nil;
        self.arrayTeacherInfo=[[NSArray alloc]initWithObjects:@"家教信息1(已完成)",@"家教信息2(已完成)",@"家教信息3(已完成)",@"家教信息4(已完成)", nil];
        [self.homeTeacherTableView reloadData];
    }
    
}
#pragma mark -TableView DataSource Method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayTeacherInfo count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString * Identifier=@"Identifier";
    EHEStdBookingTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(!cell)
    {
        cell=[[EHEStdBookingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.labelTeacherInfomation.text=[self.arrayTeacherInfo objectAtIndex:[indexPath row]];
    cell.labelDate.text=[self.arrayDate objectAtIndex:[indexPath row]];
    return cell;
}
@end
