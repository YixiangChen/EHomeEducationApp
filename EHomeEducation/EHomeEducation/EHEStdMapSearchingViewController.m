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
        self.teacherSubjectDictionary=[[NSMutableDictionary alloc]initWithCapacity:10];
        self.teacherInfoArray=[[NSArray alloc]init];
         self.teacherInfoArray=[[EHECoreDataManager getInstance] fetchBasicInfosOfTeachers];
        
        self.mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-110)];
        self.mapView.delegate=self;
        
        self.locationManager=[[CLLocationManager alloc]init];
        [self.locationManager requestWhenInUseAuthorization];
        self.mapView.showsUserLocation=YES;
        
        _locationService = [[BMKLocationService alloc]init];
        _locationService.delegate = self;
        //启动LocationService
        [_locationService startUserLocationService];
        [self.view addSubview:self.mapView];

        self.labelSubject=[[UILabel alloc]init];
        self.labelSubject.textColor=[UIColor whiteColor];
        self.labelSubject.backgroundColor=[UIColor clearColor];
        self.labelSubject.font=[UIFont systemFontOfSize:12.0f];
        
        self.labelEveluation=[[UILabel alloc]init];
        self.labelEveluation.textColor=[UIColor whiteColor];
        self.labelEveluation.backgroundColor=[UIColor clearColor];
        self.labelEveluation.font=[UIFont systemFontOfSize:12.0f];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    for(EHETeacher * teacher in self.teacherInfoArray)
    {
        BMKPointAnnotation * annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude =teacher.latitude.doubleValue;
        coor.longitude=teacher.longitude.doubleValue;
        annotation.coordinate=coor;
        annotation.title=teacher.name;
        self.labelEveluation.text=[NSString stringWithFormat:@"评价星级:%@",teacher.rank];
        self.labelSubject.text=[NSString stringWithFormat:@"科目:%@",teacher.subjectInfo];
        [_mapView addAnnotation:annotation];
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
           
           UILabel * teacherName=[[UILabel alloc]initWithFrame:CGRectMake(55,0, 150, 25)];
           teacherName.text=[NSString stringWithFormat:@"姓名:%@",pa.title];
           teacherName.textColor=[UIColor whiteColor];
           teacherName.backgroundColor=[UIColor clearColor];
           teacherName.font=[UIFont systemFontOfSize:12.0f];
           teacherImage.alpha=1.0f;
           [popView addSubview:teacherName];
           
           self.labelSubject.frame=CGRectMake(55, 22, 150, 25);
           [popView addSubview:self.labelSubject];
           
           self.labelEveluation.frame=CGRectMake(55, 45, 183, 25);
           [popView addSubview:self.labelEveluation];
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
