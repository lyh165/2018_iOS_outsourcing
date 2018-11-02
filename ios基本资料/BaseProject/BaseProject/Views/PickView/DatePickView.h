//
//  DatePickView.h
//  E_Scheduling
//
//  Created by feiwei on 16/4/25.
//  Copyright © 2016年 feiwei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DatePickBlock)(NSString *dateString);
@interface DatePickView : UIView
- (instancetype)initWithBeginDate:(NSDate *)BeginDate EndDate:(NSDate *)endDate;
@property (nonatomic,copy)DatePickBlock block;
- (void)show;
- (void)hide;
@end
