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
        self.mapViewPop=[[EHEBaiduMapView alloc]init];
        self.mapViewPop.labelTeacherName.text=teacher.name;
        self.mapViewPop.labelTeacherRank.text=[NSString stringWithFormat:@"评价星级:%@",teacher.rank];
        self.mapViewPop.labelTeacherSubject.text=[NSString stringWithFormat:@"科目:%@",teacher.subjectInfo];
        self.mapViewPop.teacherImageView.image=[UIImage imageNamed:@"png-0010"];
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
           CGSize titleSize = [self.mapViewPop.labelTeacherSubject.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
           self.mapViewPop.frame=CGRectMake(80, 0,titleSize.width+75, 70);
           self.mapViewPop.backgroundColor=[UIColor grayColor];
           self.mapViewPop.alpha=0.8;
           [self.mapViewPop.layer setCornerRadius:10];
           BMKActionPaopaoView *paopao=[[BMKActionPaopaoView alloc] initWithCustomView:self.mapViewPop];
           newAnnotationView.paopaoView=paopao;
           
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
