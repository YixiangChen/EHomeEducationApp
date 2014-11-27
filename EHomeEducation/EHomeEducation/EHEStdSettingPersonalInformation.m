//
//  EHEStdSettingPersonalInformation.m
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-27.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHEStdSettingPersonalInformation.h"
#import "EHEStdSettingTableViewCell.h"
#import "EHEStdSettingDetailViewController.h"
@interface EHEStdSettingPersonalInformation ()

@end

@implementation EHEStdSettingPersonalInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320,self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem * sendButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(sendInfomation)];
    self.navigationItem.rightBarButtonItem=sendButtonItem;
    self.image=nil;
}
-(void)sendInfomation
{
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSouce Method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 6;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * Identifier=@"Identifier";
    EHEStdSettingTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(!cell)
    {
        cell=[[EHEStdSettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    NSInteger row = [indexPath row];
    if(row==0)
    {
        cell.nameLabel.alpha=0.0f;
        cell.settingImageView.alpha=1.0f;
        cell.iconLabel.text=@"头像";
        cell.imageIcon.image=self.image;
    }
    else if(row==1)
    {
        cell.settingLabel.text=@"姓名";
        cell.contentLabel.text=self.name;
    }
    else if(row==2)
    {
        cell.settingLabel.text=@"电话号码:";
        cell.contentLabel.text=self.telephoneNumber;
    }
    else if(row==3)
    {
        cell.settingLabel.text=@"性别:";
        cell.contentLabel.text=self.gender;
        cell.contentLabel.tag=1;
    }
    else if(row==4)
    {
        cell.settingLabel.text=@"地址:";
        cell.contentLabel.text=@"北京石景山";
    }
    else
    {
        cell.settingLabel.text=@"日期:";
        cell.contentLabel.text=self.brithday;
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark - TableView Delegate Method
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section]==0)
    {
        if([indexPath row]==0)
        {
            return 70.0f;
        }
    }
    return 44.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    EHEStdSettingDetailViewController * settingDetail=[[EHEStdSettingDetailViewController alloc]init];
    NSInteger row=[indexPath row];
    if(row==0)
    {
        settingDetail.type=@"0";
    }
    else if(row==1)
    {
        settingDetail.type=@"1";
        settingDetail.name=@"张三";
    }
    else if(row==2)
    {
        settingDetail.type=@"3";
        settingDetail.telephoneNumber=@"18500813409";
        
    }
    else if(row==3)
    {
        settingDetail.type=@"2";
    }
    else if(row==4)
    {
        return;
    }
    else
    {
        settingDetail.type=@"4";
        settingDetail.birthDate=@"2000-01-01";
    }
    settingDetail.personInfomation=self;
    UITextField * textField=(UITextField *)[self.tableView viewWithTag:1];
    if([textField.text isEqualToString:@"男"])
    {
        settingDetail.currentIndexPath=0;
    }
    else if([textField.text isEqualToString:@"女"])
    {
        settingDetail.currentIndexPath=1;
    }
    [self.navigationController pushViewController:settingDetail animated:YES];
}
@end
