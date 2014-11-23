//
//  EHEStdOrderViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/21/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHEStdOrderViewController.h"
#import "EHEStdSubjectTableTableViewController.h"
#import "EHECommunicationManager.h"

@interface EHEStdOrderViewController ()
@property (strong, nonatomic) NSArray *mainPickerArraySchools;
@property (strong, nonatomic) NSArray *subPickerArrayGrades;
@property (strong, nonatomic) NSDictionary *dictPicker;
@property (strong, nonatomic) NSString *selectedGrade;
@property (strong, nonatomic) NSString *selectedSchool;
@property (strong, nonatomic) NSMutableDictionary *dictOrder;


@end

@implementation EHEStdOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"预约信息";
    

    self.mainPickerArraySchools = @[@"小学",@"初中",@"高中"];
    self.dictPicker = [NSDictionary dictionaryWithObjectsAndKeys:
                       @[@"一年级",@"二年级",@"三年级",@"四年级",@"五年级",@"六年级"], @"小学",
                       @[@"一年级",@"二年级",@"三年级"],@"初中",
                       @[@"一年级",@"二年级",@"三年级"],@"高中",
                       nil];
    self.subPickerArrayGrades = [self.dictPicker objectForKey:@"小学"];
    self.pickerView.backgroundColor = [UIColor greenColor];
    self.pickerView.frame = CGRectMake(0, 20, 320, 100);
    self.viewForPicker.frame = CGRectMake(0, 230, 320, 200);
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sendOrder)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.dictOrder = [[NSMutableDictionary alloc] init];
    [self.dictOrder setObject:@(143) forKey:@"customerid"];
    [self.dictOrder setObject:@(119.000000) forKey:@"latitude"];
    [self.dictOrder setObject:@(39.000000) forKey:@"longitude"];
    [self.dictOrder setObject:self.teacher.teacherId forKey:@"teacherid"];
    [self.dictOrder setObject:@"2014-1-1 11:11:11" forKey:@"orderdate"];
    [self.dictOrder setObject:@(0) forKey:@"orderstatus"];

}

-(void) sendOrder {

    [[EHECommunicationManager getInstance] sendOrder:self.dictOrder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if(section == 1){
        return 4;
    } else {
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"辅导对象";
            cell.detailTextLabel.text = @"高中一年级";
            
            [self.dictOrder setObject:cell.detailTextLabel.text forKey:@"objectinfo"];
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"辅导科目";
            cell.detailTextLabel.text = @"语文数学";
            
            [self.dictOrder setObject:cell.detailTextLabel.text forKey:@"subjectinfo"];
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"辅导地点";
            cell.detailTextLabel.text = @"石景山";
            
            [self.dictOrder setObject:cell.detailTextLabel.text forKey:@"serviceaddress"];
        }
    }
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"日期";
            cell.detailTextLabel.text = @"2014-12-12";
            
            [self.dictOrder setObject:cell.detailTextLabel.text forKey:@"timeperiod"];
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"开始时间";
            cell.detailTextLabel.text = @"上午九点";
            
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"结束时间";
            cell.detailTextLabel.text = @"下午三点";
            
        }
        if (indexPath.row == 3) {
            cell.textLabel.text = @"周期";
            cell.detailTextLabel.text = @"每周一";
            
        }
    }
    
    if (indexPath.section == 2) {
        cell.textLabel.text = @"备注";
        cell.detailTextLabel.text = @"非北京勿扰";
        
        [self.dictOrder setObject:cell.detailTextLabel.text forKey:@"memo"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self.view addSubview:self.viewForPicker];
        }
        if (indexPath.row == 1) {
            EHEStdSubjectTableTableViewController *subjectViewController = [[EHEStdSubjectTableTableViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:subjectViewController animated:YES];
        }
        
    }
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return [self.mainPickerArraySchools count];
    } else {
        return [self.subPickerArrayGrades count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return  [self.mainPickerArraySchools objectAtIndex:row];
    } else {
        return [self.subPickerArrayGrades objectAtIndex:row];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        self.selectedSchool = nil;
        self.subPickerArrayGrades = [self.dictPicker objectForKey:[self.mainPickerArraySchools objectAtIndex:row]];
        self.selectedSchool = [self.mainPickerArraySchools objectAtIndex:row];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        [self.pickerView reloadComponent:1];
    }else {
        self.selectedGrade = nil;
        self.selectedGrade = [self.subPickerArrayGrades objectAtIndex:row];
    }
}
- (IBAction)doneButtonPressed:(id)sender {
    [self.viewForPicker removeFromSuperview];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",self.selectedSchool,self.selectedGrade];
    [self.tableView reloadData];

}

- (IBAction)cancelButtonPressed:(id)sender {
    [self.viewForPicker removeFromSuperview];
}
@end
