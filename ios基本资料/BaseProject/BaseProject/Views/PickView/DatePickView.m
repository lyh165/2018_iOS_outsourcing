//
//  DatePickView.m
//  E_Scheduling
//
//  Created by feiwei on 16/4/25.
//  Copyright © 2016年 feiwei. All rights reserved.
//

#import "DatePickView.h"

@interface DatePickView()
{
    UIView *backView;
}
@property (nonatomic,strong)UIDatePicker *datePicker;
@property (nonatomic,strong)UIButton *completeBtn;

@end

@implementation DatePickView
- (instancetype)initWithBeginDate:(NSDate *)BeginDate EndDate:(NSDate *)endDate{
    if ([self initWithFrame:[UIScreen mainScreen].bounds]) {
        
        _datePicker.minimumDate = BeginDate;
        _datePicker.maximumDate = endDate;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:[UIScreen mainScreen].bounds]) {
        backView = [[UIView alloc]initWithFrame:self.bounds];
        backView.backgroundColor = color(0, 0, 0, 0);
        [self addSubview:backView];
        
        _completeBtn  = [UIButton buttonWithFrame:CGRectMake(0,backView.height - 40 , screen_width, 40) title:@"确定" image:nil target:self action:@selector(completeBtnAction:)];
        [_completeBtn setTitleColor:color(255, 255, 255, 1) forState:UIControlStateNormal];
//        _completeBtn.backgroundColor = orange_color;
        [self addSubview:_completeBtn];
        
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,backView.height-220,screen_width,180)];
        _datePicker.backgroundColor = color(255, 255, 255, 1);
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
        [self addSubview:_datePicker];
    }
    return self;

}
- (void)dateChanged:(UIDatePicker *)picker{
    NSDate *_date = picker.date;
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormater stringFromDate:_date];
    if (self.block) {
        self.block(dateStr);
    }
}
- (void)show{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    NSArray *windowViews = [window subviews];
//    if(windowViews && [windowViews count] > 0){
//        UIView *subView = [windowViews objectAtIndex:[windowViews count]-1];
//        for(UIView *aSubView in subView.subviews)
//        {
//            [aSubView.layer removeAllAnimations];
//        }
//        [subView addSubview:self];
//    }
    [window addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        backView.backgroundColor = color(0, 0, 0, 0.5);
        _datePicker.frame = CGRectMake(0,backView.height-220,screen_width,180);
        _completeBtn.frame = CGRectMake(0,backView.height - 40 , screen_width, 40);
    } completion:^(BOOL finished) {
    }];
}
- (void)hide{
    [self completeBtnAction:nil];
}
//移除视图
- (void)completeBtnAction:(id)sender{
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

