//
//  EHESegmentedControlManager.m
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-21.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHESegmentedControlManager.h"

@implementation EHESegmentedControlManager
-(id)initWithItems:(NSArray *)items
{
    if(self=[super initWithItems:items])
    {
        self.frame = CGRectMake(40.0, 20.0,240.0, 30.0);
        self.tintColor = [UIColor colorWithRed:192.0 / 256.0 green:233 / 256.0 blue:189 / 256.0 alpha:0.8];
        self.selectedSegmentIndex = 0;//默认选中的按钮索引
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor redColor], NSForegroundColorAttributeName, nil];
        [self setTitleTextAttributes:attributes forState:UIControlStateNormal];
        NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
        
        [self setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    }
    return self;
}
@end
