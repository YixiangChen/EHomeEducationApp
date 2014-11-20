//
//  EHEStdSettingDetailViewController.m
//  EHomeEducation
//
//  Created by ibokan on 14/11/19.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHEStdSettingDetailViewController.h"

@interface EHEStdSettingDetailViewController ()

- (IBAction)previousLevelButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIPickerView *sexChosePickerView;

@property (strong, nonatomic) IBOutlet UITextField *sexChoseTextField;
- (IBAction)switchValueChanged:(id)sender;

@end

@implementation EHEStdSettingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sexArray=[NSArray arrayWithObjects:@"男",@"女", nil];
    self.view.backgroundColor=[UIColor redColor];
    
    self.sexChosePickerView.alpha=0.0f;
    //self.sexChoseTextField.delegate=self;
    
    self.sexChoseTextField.text=@"男性";
    self.sexChoseTextField.enabled=NO;
    
    self.birthdayTextField.delegate=self;
    
    self.birthdayDatePicker.alpha=0.0f;
    // Do any additional setup after loading the view from its nib.
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
-(IBAction)clickBackground:(id)sender
{
    NSDate * date=self.birthdayDatePicker.date;
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSString * dateString=[dateFormatter stringFromDate:date];
    NSLog(@"%@",dateString);
    
    self.birthdayTextField.text=dateString;
    
    int birthday=self.birthdayTextField.text.intValue;
    NSDate * dates =[NSDate date];
    NSString * realString=[NSString stringWithFormat:@"%@",dates];
    int realAge=[realString substringWithRange:NSMakeRange(0, 4)].intValue-birthday;
    self.ageTextField.text=[NSString stringWithFormat:@"%d岁",realAge];
    self.birthdayDatePicker.alpha=0.0;
}
- (IBAction)previousLevelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark - TextField Delegate Method
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.birthdayDatePicker.alpha=1.0;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    range=NSMakeRange(0, 1);
    return NO;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    return NO;
}
#pragma mark - PickerView DataSource Method
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.sexArray count];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@",[self.sexArray objectAtIndex:row]];
}
#pragma mark - DataPicker Delegate Method
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.sexChoseTextField.text=[self.sexArray objectAtIndex:row];
}

- (IBAction)switchValueChanged:(id)sender
{
    UISwitch * switches=(UISwitch*)sender;
    if(switches.isOn)
    {
        self.sexChoseTextField.text=@"男性";
    }
    else if(![switches isOn])
    {
      self.sexChoseTextField.text=@"女性";
    }
}
@end
