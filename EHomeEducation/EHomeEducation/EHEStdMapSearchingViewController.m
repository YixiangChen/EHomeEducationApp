//
//  EHEStdMapSearchingViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/17/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHEStdMapSearchingViewController.h"
#import "TeacherAnnotations.h"
#import "EHETeacherDetailViewController.h"
#import "EHEStdSearchingViewController.h"
@interface EHEStdMapSearchingViewController ()


@end

@implementation EHEStdMapSearchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([UIScreen mainScreen].bounds.size.width==320&&[UIScreen mainScreen].bounds.size.height==480)
    {
        //实例化一个教师信息的数组，因为是从coreData中获取的，所以是不可变的数组
        self.teacherInfoArray=[[NSArray alloc]init];
         self.teacherInfoArray=[[EHECoreDataManager getInstance] fetchBasicInfosOfTeachers];
        
        //实例化一个百度地图的类
        self.mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50)];
        self.mapView.delegate=self;
        
        //利用locationManager方法添加百度地图定位功能
        self.locationManager=[[CLLocationManager alloc]init];
        [self.locationManager requestWhenInUseAuthorization];
        self.mapView.showsUserLocation=YES;
        
        //定位服务locationService
        _locationService = [[BMKLocationService alloc]init];
        _locationService.delegate = self;
        
        //启动LocationService
        [_locationService startUserLocationService];
        [self.view addSubview:self.mapView];
        
        self.count=1;
        
        self.bubbleDictionary =[[NSMutableDictionary alloc]initWithCapacity:[self.teacherInfoArray count]];
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
    if(userLocation!=nil)//如果在设备位置不为空的情况下
    {
    //创建一个大头针，本大头针要定位本地设备的位置
    BMKPointAnnotation * annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    //设置大头针的本地经纬度
    coor.latitude = userLocation.location.coordinate.latitude;
    coor.longitude = userLocation.location.coordinate.longitude;
        NSLog(@"latitude=%lf,longtitude=%lf",coor.latitude,coor.longitude);
    annotation.coordinate = coor;
    annotation.title = @"当前位置";
    [_mapView addAnnotation:annotation];
    //给地图设定一个范围：
    [self.mapView setRegion:BMKCoordinateRegionMake(coor, BMKCoordinateSpanMake(0.05, 0.05)) animated:YES];
    self.mapView.zoomEnabled=YES;
    }
    else
    {
        NSLog(@"。。。。");
    }
    //循环这个教师信息数组，以便添加教师大头针(标注)
    for(EHETeacher * teacher in self.teacherInfoArray)
    {
        BMKPointAnnotation * annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude =teacher.latitude.doubleValue;
        coor.longitude=teacher.longitude.doubleValue;
        annotation.coordinate=coor;
        annotation.title=teacher.name;//标注名字就是教师的名字
        //创建一个定义好的百度气泡类
        self.mapViewPop=[[EHEBaiduMapView alloc]init];
        //给里面的元素(名字，所教科目，评分)赋值
        self.mapViewPop.labelTeacherName.text=teacher.name;
        self.mapViewPop.labelTeacherRank.text=[NSString stringWithFormat:@"评价星级:%@",teacher.rank];
        self.mapViewPop.labelTeacherSubject.text=[NSString stringWithFormat:@"科目:%@",teacher.subjectInfo];
        self.mapViewPop.teacherImageView.image=[UIImage imageNamed:@"png-0010"];
        self.mapViewPop.teacherID=teacher.teacherId;
        self.mapViewPop.teacherGender=teacher.gender;
        //添加大头针
        [self.bubbleDictionary setObject:self.mapViewPop forKey:@(self.count)];
        
        [_mapView addAnnotation:annotation];
        self.count++;
    }
    //在定位后要停止定位，不然系统一直轮询设备造成内存泄露
    [self.locationService stopUserLocationService];
}
-(void)mapPopTouchUp:(UITapGestureRecognizer *)sender
{
    NSLog(@"Jump to another view!");
}
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    //大头针的样式设置
   if([annotation isKindOfClass:[BMKPointAnnotation class]])
   {
       //创建的大头针的View
       BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
       BMKPointAnnotation *pa = (BMKPointAnnotation *)annotation;
       //拿到大头针的标注名字，如果是当前位置，就设置当前位置的图片
       if ([pa.title isEqualToString:@"当前位置"]) {
           newAnnotationView.image=[UIImage imageNamed:@"iconmarka"];
       }
       //加载老师信息的标注
       else
       {
           NSLog(@"teacherName=%@,teacherGender=%@",self.mapViewPop.labelTeacherName.text,self.mapViewPop.teacherGender);
           if([self.mapViewPop.teacherGender isEqualToString:@"女"])
           {
               newAnnotationView.image = [UIImage imageNamed:@"female"];
           }
           else
           {
             newAnnotationView.image = [UIImage imageNamed:@"male"];
           }
           
           //根据教师所教科目这个label的长度自动调节整个气泡的宽度
           CGSize titleSize = [self.mapViewPop.labelTeacherSubject.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
           self.mapViewPop.frame=CGRectMake(80, 0,titleSize.width+75, 70);
           self.mapViewPop.backgroundColor=[UIColor grayColor];
           self.mapViewPop.alpha=1.0;
           [self.mapViewPop.layer setCornerRadius:10];
           
           //自定义气泡的创建
           BMKActionPaopaoView *paopao=[[BMKActionPaopaoView alloc] initWithCustomView:self.mapViewPop];
           //自定义气泡的赋值和加载
           paopao.tag=self.count;
           newAnnotationView.paopaoView=paopao;
       }
       newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
       return newAnnotationView;
   }
    return nil;
}
-(void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    EHEBaiduMapView * mapViewBubble= [self.bubbleDictionary objectForKey:@(view.paopaoView.tag)];
    NSLog(@"teacherid=%@,teacherName=%@",mapViewBubble.teacherID,mapViewBubble.labelTeacherName.text);
    EHECoreDataManager * coreDataManager=[EHECoreDataManager getInstance];
    EHETeacher * teacherInfo= [coreDataManager fetchDetailInfosWithTeacherId:mapViewBubble.teacherID.intValue];
    EHETeacherDetailViewController * teacherDetailViewController=[[EHETeacherDetailViewController alloc]initWithNibName:nil bundle:nil];
    teacherDetailViewController.teacher=teacherInfo;
    [self.searchingViewController.navigationController pushViewController:teacherDetailViewController animated:YES];
}
-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
}
-(void)viewDidDisappear:(BOOL)animated
{
    self.mapView=nil;
}
@end
