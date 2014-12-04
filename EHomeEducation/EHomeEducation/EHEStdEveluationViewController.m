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
    
    self.commonTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-120) style:UITableViewStyleGrouped];
    self.commonTableView.dataSource=self;
    self.commonTableView.delegate=self;
    self.commonTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.commonTableView];
    
    self.teacherName=[[NSMutableArray alloc]initWithCapacity:10];
    self.commonArray=[[NSMutableArray alloc]initWithCapacity:10];
    self.commonDate=[[NSMutableArray alloc]initWithCapacity:10];
    self.commonDictionary=[[NSMutableDictionary alloc]initWithCapacity:10];
    self.commonInfomation=[[NSMutableArray alloc]initWithCapacity:10];
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * customerid=[userDefaults objectForKey:@"myCustomerid"];
    NSLog(@"customerid=%@",customerid);
    EHECommunicationManager * communicationManager=[EHECommunicationManager getInstance];
    self.allCommentsArray=[communicationManager loadCommentsWithCustomerId:customerid.intValue];
    NSLog(@"commentsArray=%@",self.allCommentsArray);
    
    for(NSDictionary * dic in self.allCommentsArray)
    {
        NSNumber * teacherName=[dic objectForKey:@"teacherid"];
        [self.teacherName addObject:teacherName];
    }
    
    for(int i=0;i<self.teacherName.count;i++)
    {
        NSDictionary * dic=[self.allCommentsArray objectAtIndex:i];
        NSNumber * teacher1=[self.teacherName objectAtIndex:i];
        NSNumber * teacher2=[dic objectForKey:@"teacherid"];
        if(teacher1 ==teacher2)
        {
            [self.commonArray addObject:[dic objectForKey:@"content"]];
            [self.commonArray addObject:[dic objectForKey:@"commentdate"]];
            NSArray * array=[[NSArray alloc]initWithObjects:self.commonArray,nil];
            [self.commonDictionary setObject:array forKey:[self.teacherName objectAtIndex:i]];
        }
    }
    NSLog(@"commonDic=%@",self.commonDictionary);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- TableView DataSource Method-
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"%d",[self.commonDictionary.allKeys count]);
    return [self.commonDictionary.allKeys count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * allkeys=[self.commonDictionary allKeys];
    NSArray * allValues=[self.commonDictionary objectForKey:[allkeys objectAtIndex:section]];
    NSLog(@"%d",allValues.count);
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
    NSInteger row=[indexPath row];
    NSArray * allContents=[self.commonDictionary objectForKey:[allTeacherids objectAtIndex:section]];
    NSArray * contentAndDate=[allContents objectAtIndex:row];
    cell.textLabel.text=[contentAndDate objectAtIndex:0];
    cell.detailTextLabel.text=[contentAndDate objectAtIndex:1];
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray * allKeys = [self.commonDictionary allKeys];
    NSNumber * key=[allKeys objectAtIndex:section];
    NSDictionary * teacherDic= [self loadDataWithTeacherID:key.intValue];
    NSString * teacherName= [[teacherDic objectForKey:@"teacherinfo"] objectForKey:@"name"];
    return [NSString stringWithFormat:@"%@对你说......",teacherName];
}
-(NSDictionary *)loadDataWithTeacherID:(int) teacherId {
    
    NSString * postData = [NSString stringWithFormat:@"{\"teacherid\":\"%d\"}",teacherId];
    
    NSString *stringForURL = [NSString stringWithFormat:@"%@%@",kURLDomain,kURLFindTeacherDetail];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSString * resposeString=[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"responseString=%@",resposeString);
    NSDictionary * dic=nil;
    if(responseData != nil && error == nil){
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
       // NSDictionary *dictTeacherInfo = dict[@"teacherinfo"];
        NSLog(@"dict=%@",dict);
        if([dict[@"code"] intValue] == 0){
           dic=dict;
        }else{
            dic= nil;
        }
    }
    return dic;
}
@end
