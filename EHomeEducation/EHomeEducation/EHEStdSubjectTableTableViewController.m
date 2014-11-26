//
//  EHEStdSubjectTableTableViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/23/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHEStdSubjectTableTableViewController.h"
#import "EHEStdOrderViewController.h"

@interface EHEStdSubjectTableTableViewController ()
@property (strong, nonatomic) NSMutableArray *subjectsArray;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation EHEStdSubjectTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
 
    NSArray *subjects = @[@"语文",@"数学",@"英语",@"历史",@"地理",@"生物",@"政治",@"音乐",@"绘画",@"舞蹈",@"其他"];
    self.subjectsArray = [[NSMutableArray alloc] initWithArray:subjects];
    NSDictionary *dict = @{@"isSelected":@(NO)};
    NSArray *array = @[dict,dict,dict,dict,dict,dict,dict,dict,dict,dict,dict];
    self.dataArray = [[NSMutableArray alloc] initWithArray:array];
    
    self.navigationItem.leftBarButtonItem.title = @"保存";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.selectedSubjects = [self getSelectedSubjects];
    self.orderTable.selectedSubjects = self.selectedSubjects;
    [self.orderTable.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.subjectsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    // Configure the cell...
    cell.textLabel.text = [self.subjectsArray objectAtIndex:indexPath.row];
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    BOOL isSelected = [[self.dataArray[indexPath.row] objectForKey:@"isSelected"] boolValue];
    if (isSelected) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    NSDictionary *newDict = @{@"isSelected":@(!isSelected)};
    [self.dataArray replaceObjectAtIndex:indexPath.row withObject:newDict];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSString *)getSelectedSubjects {
    NSMutableString *selectedSubjects = [[NSMutableString alloc] init];
    NSDictionary *dict;
    for (int i =0; i<self.dataArray.count; i++) {
        dict = [self.dataArray objectAtIndex:i];
        if ([[dict objectForKey:@"isSelected"] boolValue]) {
            [selectedSubjects appendString:self.subjectsArray[i]];
        }
    }
    return selectedSubjects;
    
}
    


@end
