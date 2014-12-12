//
//  EHEStdEveluationViewController.m
//  EHomeEducation
//
//  Created by MacBook Pro on 14-12-2.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHEStdEveluationViewController.h"
#import "EHECommunicationManager.h"
#import "EHEStdCommentCell.h"
#import "EHETeacher.h"
#import "EHECoreDataManager.h"
#import "Defines.h"
@interface EHEStdEveluationViewController ()

@end

@implementation EHEStdEveluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"评论";
    
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if(screenWidth==320&&screenHeight==480)
    {
        self.commonTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-120) style:UITableViewStyleGrouped];
    }
    else if(screenWidth==320&&screenHeight==568)
    {
        self.commonTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-120) style:UITableViewStyleGrouped];
    }
    else if(screenWidth==375&&screenHeight==667)
    {
        self.commonTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 667) style:UITableViewStyleGrouped];
    }
    else if(screenWidth==414&&screenHeight==736)
    {
        self.commonTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 414,736) style:UITableViewStyleGrouped];
    }
    self.commonTableView.dataSource=self;
    self.commonTableView.delegate=self;
    self.commonTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.commonTableView];
    
    self.teacherName=[[NSMutableArray alloc]initWithCapacity:10];
    self.commonArray=[[NSMutableArray alloc]initWithCapacity:10];
    self.commonDate=[[NSMutableArray alloc]initWithCapacity:10];
    self.commonDictionary=[[NSMutableDictionary alloc]initWithCapacity:10];
    self.commonInfomation=[[NSMutableArray alloc]initWithCapacity:10];
    self.sets=[[NSMutableSet alloc]initWithCapacity:10];
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * customerid=[userDefaults objectForKey:@"myCustomerid"];
    NSLog(@"customerid=%@",customerid);
    EHECommunicationManager * communicationManager=[EHECommunicationManager getInstance];
    self.allCommentsArray=[communicationManager loadCommentsWithCustomerId:customerid.intValue];
    NSLog(@"commentsArray=%@",self.allCommentsArray);
    
    for(NSDictionary * dic in self.allCommentsArray)
    {
        NSNumber * teacherName=[dic objectForKey:@"teacherid"];
        [self.sets addObject:teacherName];
    }
    NSLog(@"teacherName=%@",self.sets);
    
    for(NSNumber * number in self.sets)
    {
        NSMutableArray * arrayInfo=[[NSMutableArray alloc]initWithCapacity:0];
        for(int i=0;i<[self.allCommentsArray count];i++)
        {
            NSDictionary * dict= [self.allCommentsArray objectAtIndex:i];
            NSNumber * teacherid=[dict objectForKey:@"teacherid"];
            NSLog(@"teacherid=%@,number=%@",teacherid,number);
           if(teacherid.intValue==number.intValue)
           {
               NSString * content=[dict objectForKey:@"content"];
               if([content isEqualToString:@""])
               {
               }
               else
               {
               [arrayInfo addObject:[dict objectForKey:@"content"]];
               }
           }
        }
        [self.commonDictionary setObject:arrayInfo forKey:number];
    }
    NSLog(@"self.commonDicitonary=%@",self.commonDictionary);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    //[self.commonTableView reloadData];
}
#pragma mark- TableView DataSource Method-
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"self.commonDic=%d",self.commonDictionary.allKeys.count);
    return [self.commonDictionary.allKeys count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * allkeys=[self.commonDictionary allKeys];
    NSArray * allValues=[self.commonDictionary objectForKey:[allkeys objectAtIndex:section]];
    return [allValues count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * Identifier=@"Identifier";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }
    NSArray * allTeacherids=[self.commonDictionary allKeys];
    NSInteger section=[indexPath section];
    NSArray * allContents=[self.commonDictionary objectForKey:[allTeacherids objectAtIndex:section]];
    NSString * content=[allContents objectAtIndex:[indexPath row]];
    NSLog(@"content=%@",content);
    cell.textLabel.text=content;
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSNumber * teacherid = [self.commonDictionary.allKeys objectAtIndex:section];
    [self loadDataWithTeacherID:teacherid.intValue];
    NSString * teacherName= [[self.teacherDic objectForKey:@"teacherinfo"] objectForKey:@"name"];
    return [NSString stringWithFormat:@"%@对你说......",teacherName];
}

-(void)loadDataWithTeacherID:(int) teacherId {
    
    NSString * postData = [NSString stringWithFormat:@"{\"teacherid\":\"%d\"}",teacherId];
    
    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLFindTeacherDetail];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.teacherDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }];
}
@end
