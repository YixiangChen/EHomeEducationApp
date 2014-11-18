//
//  EHEStdSearchingTableViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/17/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHEStdSearchingTableViewController.h"
#import "AFNetworking.h"

@interface EHEStdSearchingTableViewController ()

@end

@implementation EHEStdSearchingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *refreshBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem = refreshBarBtn;
}

-(void) refresh{
    NSLog(@"refreshing.........");
//    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://music.baidu.com/data/music/file?link=http://yinyueshiting.baidu.com/data2/music/123297915/12012502946800128.mp3?xcode=333287cb95b06768f993b49e577e9bf4a6a03c85c06f4409&song_id=120125029"]];
//        AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
//        
//        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//            //将设置给player
//            self.player = [[AVAudioPlayer alloc]initWithData:responseObject error:nil];
//            [self.player play];//播放
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            //请求失败之后的执行的方法
//            NSLog(@"error:%@",error);
//        }];
//        
//        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//            //主线程中执行，将进度条改变
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.progressView.progress = totalBytesRead * 1.0 / totalBytesExpectedToRead;
//            });
//        }];
//        //让操作启动
//        [operation start];
    
    NSString * postData = [NSString stringWithFormat:@"{\"customerid\":\"%d\",\"latitude\":\"%f\",\"longitude\":\"%f\",\"distancefilter\":\"%f\",\"keyword\":\"%s\"}",0,39.0000000,119.0000000,1000.0,""];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://218.249.130.194:8080/ehomeedu/api/customer/findteacherlist.action"]];
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSString *string = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
    if(responseData != nil){
        //使用系统自带JSON解析方法
        NSError *error = nil;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"%@",dict);
        NSLog(@"%@",dict[@"code"]);
        if([dict[@"code"] intValue] == 0){
            //注册成功，
            //int uid = [dict[@"id"] intValue]; //得到服务器端生成的用户编号。
           // NSLog(@"%@,id:%d",dict[@"message"],uid);
            NSLog(@"正在打印教师信息");
            NSLog(@"%@",dict);
        }else{
            NSLog(@"%@",dict[@"message"]);
        }
    }

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
