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
    
    //暂时先不用刷新表，待拿到真实数据然后进行意见统一后在用
    
    //创建一个自定义的segmentedControl，方法已经封装
    self.segmentedControl =[[EHESegmentedControlManager alloc]initWithItems:[NSArray arrayWithObjects:@"未完成预约",@"已完成预约", nil]];
    [self.segmentedControl addTarget:self action:@selector(selectedSegmentChanged:)forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentedControl;
    
    //给tableView的数据源添加假数据
    self.arrayTeacherInfo=[[NSArray alloc]initWithObjects:@"家教信息1(未完成)",@"家教信息2(未完成)",@"家教信息3(未完成)",@"家教信息4(未完成)", nil];
    self.arrayDate=[[NSArray alloc]initWithObjects:@"2014-02-14",@"2014-02-14",@"2014-02-14",@"2014-02-14", nil];
    
    //创建tableView并且给之放置样式
    self.homeTeacherTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.homeTeacherTableView.dataSource=self;
    self.homeTeacherTableView.delegate=self;
    //分割线为单线分割
    self.homeTeacherTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.homeTeacherTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//当segmentedControl方法改变时，触发该方法
-(void) selectedSegmentChanged:(UISegmentedControl *) seg {
    if(seg.selectedSegmentIndex==0)//当点击未完成预约时
    {
        self.arrayTeacherInfo=nil;
        self.arrayTeacherInfo=[[NSArray alloc]initWithObjects:@"家教信息1(未完成)",@"家教信息2(未完成)",@"家教信息3(未完成)",@"家教信息4(未完成)", nil];
        //刷新tableView
        [self.homeTeacherTableView reloadData];
    }
    else//当点击已完成预约时
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
