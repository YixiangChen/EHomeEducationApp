//
//  EHEStdSettingViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/17/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHEStdSettingViewController.h"
@interface EHEStdSettingViewController ()

@end

@implementation EHEStdSettingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title=@"设置";
    self.tableViewSetting=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60) style:UITableViewStyleGrouped];
    self.tableViewSetting.dataSource=self;
    self.tableViewSetting.delegate=self;
    self.tableViewSetting.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableViewSetting];
    
    self.personalInfomationArray=[NSArray arrayWithObject:@"个人设置"];
    self.systemSettingArray=[NSArray arrayWithObjects:@"系统设置", nil];
    self.connectAndShareArray=[NSArray arrayWithObjects:@"分享",@"联系我们", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- TableView DataSource Method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return [self.personalInfomationArray count];
    }
    else if(section==1)
    {
        return [self.systemSettingArray count];
    }
    else
    {
        return [self.connectAndShareArray count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * Identifier=@"Identifier";
    EHEStdSettingTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(!cell)
    {
        cell=[[EHEStdSettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    if(section==0)
    {
        cell.settingLabel.text=[self.personalInfomationArray objectAtIndex:row];
        cell.settingImageView.image=[UIImage imageNamed:@"png-0010"];
    }
    else if(section==1)
    {
        cell.settingLabel.text=[self.systemSettingArray objectAtIndex:row];
    }
    else
    {
        cell.settingLabel.text=[self.connectAndShareArray objectAtIndex:row];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark- TableView Delegate Method
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self.tableViewSetting deselectRowAtIndexPath:indexPath animated:NO];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  if(section==0)
  {
      return @"个人资料";
  }
    else  if(section==1)
    {
     return @"系统设置";
    }
    else
    {
        return @"联系我们";
    }
}
@end
