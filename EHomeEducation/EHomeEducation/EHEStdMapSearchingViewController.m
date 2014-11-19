//
//  EHEStdMapSearchingViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/17/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHEStdMapSearchingViewController.h"
#import "TeacherAnnotations.h"
@interface EHEStdMapSearchingViewController ()

@end

@implementation EHEStdMapSearchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([UIScreen mainScreen].bounds.size.width==320&&[UIScreen mainScreen].bounds.size.height==480)
    {
        self.backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
        self.backgroundView.backgroundColor=[UIColor colorWithRed:150/255.0f green:205/255.0f blue:251/255.0f alpha:1.0f];
        [self.view addSubview:self.backgroundView];
        
        self.segmentedData= [[NSArray alloc]initWithObjects:@"列表",@"地图",nil];
        self.segmentedControl = [[UISegmentedControl alloc]initWithItems:self.segmentedData];
        self.segmentedControl.frame = CGRectMake(40.0, 20.0,240.0, 30.0);
        /*
         这个是设置按下按钮时的颜色
         */
        self.segmentedControl.tintColor = [UIColor colorWithRed:49.0 / 256.0 green:148.0 / 256.0 blue:208.0 / 256.0 alpha:1];
        self.segmentedControl.selectedSegmentIndex = 0;//默认选中的按钮索引
        
        
        /*
         下面的代码实同正常状态和按下状态的属性控制,比如字体的大小和颜色等
         */
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor redColor], NSForegroundColorAttributeName, nil];
        
        
        [self.segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
        
        
        NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
        
        [self.segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
        
        //设置分段控件点击相应事件
        [self.segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
        
        [self.backgroundView insertSubview:self.segmentedControl atIndex:0];
        
        
        self.mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-110)];
        self.mapView.delegate=self;
        
        self.locationManager=[[CLLocationManager alloc]init];
        [self.locationManager requestWhenInUseAuthorization];
        self.mapView.showsUserLocation=YES;
        
        _locationService = [[BMKLocationService alloc]init];
        _locationService.delegate = self;
        //启动LocationService
        [_locationService startUserLocationService];
        [self.view addSubview:self.mapView];
        
        BMKPointAnnotation * annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude =39.912811;
        coor.longitude =116.201575;
        annotation.coordinate = coor;
        annotation.title = @"郭老师";
        [_mapView addAnnotation:annotation];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doSomethingInSegment:(UISegmentedControl *)Seg
{
   if(Seg.selectedSegmentIndex==0)
   {
       NSLog(@"这是地图");
   }
   else
   {
       NSLog(@"这是列表");
   }
}
#pragma mark - LocationService Delegate Method
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
    
}
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    if(userLocation!=nil)
    {
    BMKPointAnnotation * annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = userLocation.location.coordinate.latitude;
    coor.longitude = userLocation.location.coordinate.longitude;
    annotation.coordinate = coor;
    annotation.title = @"当前位置";
    [_mapView addAnnotation:annotation];
    [self.mapView setRegion:BMKCoordinateRegionMake(coor, BMKCoordinateSpanMake(0.05, 0.05)) animated:YES];
    self.mapView.zoomEnabled=YES;
    }
    else
    {
        NSLog(@"。。。。");
    }
    [self.locationService stopUserLocationService];
}
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
   if([annotation isKindOfClass:[BMKPointAnnotation class]])
   {
       BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
       BMKPointAnnotation *pa = (BMKPointAnnotation *)annotation;
       if ([pa.title isEqualToString:@"当前位置"]) {
           newAnnotationView.image=[UIImage imageNamed:@"iconmarka"];
       }
       else
       {
           newAnnotationView.image = [UIImage imageNamed:@"png-0099"];
           
           UIView * popView =[[UIView alloc] initWithFrame:CGRectMake(80, 0,self.view.frame.size.width-150, 70)] ;
           popView.backgroundColor=[UIColor grayColor];
           popView.alpha=0.8;
           [popView.layer setCornerRadius:10];
           BMKActionPaopaoView *paopao=[[BMKActionPaopaoView alloc] initWithCustomView:popView];
           newAnnotationView.paopaoView=paopao;
           
           UIImageView * teacherImage=[[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 50, 50)];
           teacherImage.image=[UIImage imageNamed:@"png-0010"];
           teacherImage.alpha=1.0f;
           [popView addSubview:teacherImage];
           
           UILabel * teacherName=[[UILabel alloc]initWithFrame:CGRectMake(55,0, 50, 25)];
           teacherName.text=@"姓名：";
           teacherName.textColor=[UIColor whiteColor];
           teacherName.backgroundColor=[UIColor clearColor];
           teacherName.font=[UIFont systemFontOfSize:12.0f];
           teacherImage.alpha=1.0f;
           [popView addSubview:teacherName];
           
           UILabel * teacherSubject=[[UILabel alloc]initWithFrame:CGRectMake(55, 22, 50, 25)];
           teacherSubject.text=@"科目：";
           teacherSubject.textColor=[UIColor whiteColor];
           teacherSubject.backgroundColor=[UIColor clearColor];
           teacherSubject.font=[UIFont systemFontOfSize:12.0f];
           [popView addSubview:teacherSubject];
           
           UILabel * teacherEveluation=[[UILabel alloc]initWithFrame:CGRectMake(55, 45, 63, 25)];
           teacherEveluation.text=@"评价星级：";
           teacherEveluation.textColor=[UIColor whiteColor];
           teacherEveluation.backgroundColor=[UIColor clearColor];
           teacherEveluation.font=[UIFont systemFontOfSize:12.0f];
           [popView addSubview:teacherEveluation];
       }
       newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
       //自定义气泡
       
       
       
       return newAnnotationView;
   }
    return nil;
}
-(void)viewDidDisappear:(BOOL)animated
{
    self.mapView=nil;
}


@end
