//
//  EHEStdSettingViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/17/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHEStdSettingViewController.h"
#import "EHEStdSettingDetailViewController.h"
@interface EHEStdSettingViewController ()

@end

@implementation EHEStdSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array1=[[NSArray alloc]initWithObjects:@"名字", nil];
    self.array2=[[NSArray alloc]initWithObjects:@"系统设置",@"分享", nil];
    self.array3=[[NSArray alloc]initWithObjects:@"关于", nil];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableView DataSource Method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if(section==0)
  {
      return [self.array1 count];
  }
    else if(section==1)
    {
        return [self.array2 count];
    }
    else
    {
     
        return [self.array3 count];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString * Identifier=@"Identifier";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    if([indexPath section]==0)
    {
        cell.textLabel.text=[self.array1 objectAtIndex:[indexPath row]];
        cell.imageView.image=[UIImage imageNamed:@"11.0.jpg"];
    }
    else if([indexPath section]==1)
    {
         cell.textLabel.text=[self.array2 objectAtIndex:[indexPath row]];
    }
    else
    {
       cell.textLabel.text=[self.array3 objectAtIndex:[indexPath row]];
    }
    return  cell;
}
#pragma mark - TableView Delegate Meythod
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if([indexPath section]==0)
   {
     if([indexPath row]==0)
     {
         return 60.0f;
     }
   }
    return 44.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section]==0)
    {
        if([indexPath row]==0)
        {
            EHEStdSettingDetailViewController * detailViewController=[[EHEStdSettingDetailViewController alloc]initWithNibName:@"EHEStdSettingDetailViewController" bundle:nil];//create a new class
    
            [self presentViewController:detailViewController animated:YES completion:nil];//translate to the distination view controller
        }
    }
}
@end
