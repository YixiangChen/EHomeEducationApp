//
//  EHETeacherDetailViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/20/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHETeacherDetailViewController.h"

@interface EHETeacherDetailViewController ()
@property (strong, nonatomic) NSMutableArray *infoArray;
@property (strong, nonatomic) NSMutableDictionary *teacherDict;
@end

@implementation EHETeacherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadTeacherInfos];
   
    CGSize newSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 30);
    [self.scrollView setContentSize:newSize];
    [self setExtraCellLineHidden:self.tableView];

}

-(void) loadTeacherInfos {
    self.lblName.text = self.teacher.name;
    self.lblAge.text = [NSString stringWithFormat:@"年龄：30"];
    self.lblGender.text = [NSString stringWithFormat:@"性别：%@",self.teacher.gender];
    if ([self.teacher.gender isEqualToString:@"男"]) {
        self.teacherImage.image = [UIImage imageNamed:@"male_tablecell.png"];
    } else {
        self.teacherImage.image = [UIImage imageNamed:@"female_tablecell.png"];
    }
    self.lblRank.text = [NSString stringWithFormat:@"评价：%@", self.teacher.rank];
    
    self.infoArray = [[NSMutableArray alloc] initWithArray:@[@"电话",@"qq",@"微博",@"辅导时间",@"辅导科目",@"毕业院校",@"个性签名"]];
    self.teacherDict = [[NSMutableDictionary alloc] init];
    [self.teacherDict setObject:self.teacher.telephone forKey:@"0"];
    [self.teacherDict setObject:self.teacher.qq forKey:@"1"];
    [self.teacherDict setObject:self.teacher.sinaweibo forKey:@"2"];
    [self.teacherDict setObject:self.teacher.timePeriod forKey:@"3"];
    [self.teacherDict setObject:self.teacher.subjectInfo forKey:@"4"];
    //[self.teacherDict setObject:self.teacher.majorAdress forKey:@"6"];
    [self.teacherDict setObject:self.teacher.degree forKey:@"5"];
    [self.teacherDict setObject:self.teacher.memo forKey:@"6"];
    
}

- (void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    [tableView setTableHeaderView:view];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ :   %@",self.infoArray[indexPath.row], self.teacherDict[[NSString stringWithFormat:@"%d",indexPath.row]]];
    
    return cell;
}
- (IBAction)callButtonPressed:(id)sender {
    NSLog(@"call button is pressed");
}

- (IBAction)bookButtonPressed:(id)sender {
    NSLog(@"book button is pressed");
}
@end
