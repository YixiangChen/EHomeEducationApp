//
//  Defines.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/26/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#ifndef EHomeEducation_Defines_h
#define EHomeEducation_Defines_h

// url

#define kURLDomain                  @"http://218.249.130.194:8080/ehomeedu/api/customer/"
#define kURLFindTeacherList         @"findteacherlist.action"
#define kURLFindTeacherDetail       @"findteacherdetail.action"
#define kURLFindOrderList           @"findorderlist.action"
#define kURLFindOrderDetail         @"findorderdetail.action"
#define kURLReserveTeacher          @"reserveteacher.action"
#define kURLUserOtherInfo           @"userotherinfo.action"
#define kURLCancelOrder             @"cancelorder.action"
#define kURLCompleteOrder           @"completeorder.action"
#define kURLUploadIcon              @"usericonupload.action"
#define kURLCommentTeacher          @"commentteacher.action"
#define kURLFindTeacherComments     @"findteachercomments.action"
#define kURLDeleteOrder             @"http://218.249.130.194:8080/ehomeedu/api/common/deleteorder.action"
#define kURLLoadUserIcon            @"http://218.249.130.194:8080/ehomeedu"
#define kURLFindCustomerComments    @"http://218.249.130.194:8080/ehomeedu/api/teacher/findcustomercomments.action"

// System
#define SYSTEM_VERSION [UIDevice currentDevice].systemVersion.floatValue


// storyboard identifier


// segue identifier


// Fonts
#define kYueYuanFont                @"MF YueYuan (Noncommercial)"
#define kFangZhengKaTongFont        @"FZKATJW--GB1-0"
#define kMengNaFont                 @"MYoungHKS"

// colors
#define kLightGreenForMainColor    [UIColor colorWithRed:192.0 / 256.0 green:233 / 256.0 blue:189 / 256.0 alpha:0.8]
#define kGreenForTabbaritem        [UIColor colorWithRed:160.0 / 256.0 green:233 / 256.0 blue:150 / 256.0 alpha:1]

// Notifications
#define kRefreshHomeScreenNotification       @"net.plazz.exklusiv_muenchen.notification.refresh_home_screen"

// consts
#define kScaleFactorX                       768.0f / 320.0f
#define kScaleFactorY                       1024.0f / 568.0f

// font sizes home screen
#define kTypFontSize                        14.0f
#define kTitleFontSize                      20.0f
#define kEventDateNameFontSize              18.0f
#define kEventDayNumberFontSize             50.0f

// font sizes news overview
#define kDateFontSize                       14.0f
#define kNewstitleFontSize                  20.0f

// enums


#endif
