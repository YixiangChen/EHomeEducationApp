//
//  EHETchDetailViewController.m
//  EHomeEduCustomer
//
//  Created by Yixiang Chen on 12/9/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "Defines.h"
#import "EHETchDetailViewController.h"
#import "EHECommunicationManager.h"
#import "EHEStdOrderViewController.h"

#import "EHETchImageCell.h"
#import "EHETchRegularCell.h"


@interface EHETchDetailViewController ()

@property (strong, nonatomic) UIButton *call_btn;
@property (strong, nonatomic) UIButton *book_btn;
@property (strong, nonatomic) UIButton *leftBarButton;

@end

@implementation EHETchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;

    self.tableView.backgroundView = nil;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;

    if(screenWidth==320&&screenHeight==480)
    {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    }
    else if(screenWidth==320&&screenHeight==568)
    {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    }
    else if(screenWidth==375&&screenHeight==667)
    {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 600) style:UITableViewStylePlain];
    }
    else if(screenWidth==414&&screenHeight==736)
    {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 414, 680) style:UITableViewStylePlain];
    }
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    self.leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(3, 8, 90, 30)];
    [self.leftBarButton setTitle:@"< 返回列表" forState:UIControlStateNormal];
    [self.leftBarButton.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:18]];
    [self.leftBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.leftBarButton setBackgroundColor:kGreenForTabbaritem];
    [self.leftBarButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    CALayer * leftBarButtonLayer =  [self.leftBarButton layer];
    [leftBarButtonLayer setMasksToBounds:YES];
    [leftBarButtonLayer setCornerRadius:5.0];
    [leftBarButtonLayer setBorderWidth:0.5];
    [leftBarButtonLayer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.navigationController.navigationBar addSubview:self.leftBarButton];
    
    [self.tabBarController.tabBar setHidden:YES];
    [self configureTabbar];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    [self.leftBarButton removeFromSuperview];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *imageCellId = @"imageCell";
    static NSString *regularCellId = @"regular";
    

    if (indexPath.row == 0) {
        EHETchImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:imageCellId];
        if (imageCell == nil) {
            imageCell = (EHETchImageCell *)[[NSBundle mainBundle] loadNibNamed:@"EHETchImageCell" owner:self options:nil][0];
        }
        imageCell.lblName.text = self.teacher.name;
        imageCell.lblEvaluation.text = [NSString stringWithFormat:@"评价：%@",self.teacher.rank];
        imageCell.lblDistance.text = self.distance;
        
        imageCell.imageViewTch.image = nil;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *imageName = [NSString stringWithFormat:@"image_for_teacher_%d",[self.teacher.teacherId intValue]];
        NSData *data = [defaults objectForKey:imageName];
        UIImage * imageForTeacher = [[UIImage alloc] initWithData:data];
        
        if (imageForTeacher == nil)
        {
            
            if ([self.teacher.gender isEqualToString:@"男"]) {
                imageForTeacher = [UIImage imageNamed:@"male_tablecell"];
            }else {
                imageForTeacher = [UIImage imageNamed:@"female_tablecell"];
            }
            
            
            imageCell.imageViewTch.image = imageForTeacher;
            [[EHECommunicationManager getInstance] loadTeacherIconForTeacher:self.teacher completionBlock:^(NSString * status)  {
                if ([status isEqualToString:kConnectionSuccess])
                {
                    NSData * image_data = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"image_for_teacher_%d",self.teacher.teacherId.intValue]];
                    UIImage *image = [[UIImage alloc] initWithData:image_data];
                    imageCell.imageViewTch.image = image;
                }
            }];
            
        }
        else {
            imageCell.imageViewTch.image = imageForTeacher;
        }

        return imageCell;
    }else {
        EHETchRegularCell *regularCell = [tableView dequeueReusableCellWithIdentifier:regularCellId];
        if (regularCell == nil) {
            regularCell = (EHETchRegularCell *) [[NSBundle mainBundle] loadNibNamed:@"EHETchRegularCell" owner:self options:nil][0];
        }
        
        regularCell.tchDetailViewController = self;
        [regularCell setContent:self.teacher withRowIndex:indexPath.row];
        return regularCell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 145;
    }
    return 44;
}

-(void) configureTabbar {
    UIImageView *imgView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"lightgreen.png"]];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    UIButton *btn_Call = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if(screenWidth==320&&screenHeight==480)
    {
        imgView.frame = CGRectMake(0, 425, imgView.image.size.width, 60);
        btn_Call.frame = CGRectMake(185,10, 105 , 30);
    }
    else if(screenWidth==320&&screenHeight==568)
    {
        imgView.frame = CGRectMake(0, 513, imgView.image.size.width, 60);
        btn_Call.frame = CGRectMake(185,10, 105 , 30);
    }
    else if(screenWidth==375&&screenHeight==667)
    {
        imgView.frame = CGRectMake(0, 607, 375, 60);
        btn_Call.frame = CGRectMake(235,10, 105 , 30);
    }
    else if(screenWidth==414&&screenHeight==736)
    {
       imgView.frame = CGRectMake(0, 676, 414, 60);
        btn_Call.frame = CGRectMake(245,10, 105 , 30);
    }
    
    imgView.userInteractionEnabled = YES;
    
    [self.view addSubview:imgView];
    
    
    //创建按钮
    
    
    [btn_Call setBackgroundColor:kGreenForTabbaritem];
    [btn_Call setTitle:@"预约" forState:UIControlStateNormal];
    [btn_Call.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:20]];
    [btn_Call addTarget:self action:@selector(makeAnAppointment) forControlEvents:UIControlEventTouchUpInside];
    CALayer * layer_callBtn =  [btn_Call layer];
    [layer_callBtn setMasksToBounds:YES];
    [layer_callBtn setCornerRadius:10.0];
    [layer_callBtn setBorderWidth:2.0];
    [layer_callBtn setBorderColor:[[UIColor whiteColor] CGColor]];
    self.call_btn = btn_Call;
    [imgView addSubview:self.call_btn];
    
    
    
    
    UIButton *btn_book = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_book.frame = CGRectMake(30,10, 105 , 30);
    [btn_book setBackgroundColor:kGreenForTabbaritem];
    [btn_book setTitle:@"呼叫" forState:UIControlStateNormal];
    [btn_book.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:20]];
    [btn_book addTarget:self action:@selector(makeACall) forControlEvents:UIControlEventTouchUpInside];
    CALayer * layer_bookBtn =  [btn_book layer];
    [layer_bookBtn setMasksToBounds:YES];
    [layer_bookBtn setCornerRadius:10.0];
    [layer_bookBtn setBorderWidth:2.0];
    [layer_bookBtn setBorderColor:[[UIColor whiteColor] CGColor]];
    self.book_btn = btn_book;
    [imgView addSubview:self.book_btn];
    
    [self.view addSubview:imgView];
}

-(void) makeAnAppointment {

    EHEStdOrderViewController *orderViewController = [[EHEStdOrderViewController alloc] init];
    [self.navigationController pushViewController:orderViewController animated:YES];
    orderViewController.teacher = self.teacher;
}

-(void) makeACall {

    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.teacher.telephone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

-(void)backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
