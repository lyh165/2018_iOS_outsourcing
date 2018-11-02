//
//  QuickControl.h
//  FreeLimit1413
//
//  Created by mac on 14-6-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//目的为了快速创建控件
//  label,button,imageView
@interface UILabel (QuickControl)
//快速创建label的方法
+(id)labelWithFrame:(CGRect)frame text:(NSString *)text font:(float)fontSize textColor:(UIColor *)color;

//添加快速创建的方法
+(id)DelectLabelWithFrame:(CGRect)frame text:(NSString *)text font:(float)fontSize textColor:(UIColor *)color;
@end

@interface UIButton (QuickControl)
//快速创建按钮的方法
+(id)buttonWithFrame:(CGRect)frame
               title:(NSString *)title
               image:(NSString *)image
              target:(id)target
              action:(SEL)action;

+(id)buttonWithFrame:(CGRect)frame
               title:(NSString *)title
               image:(NSString *)image
              target:(id)target
              action:(SEL)action Textcolor:(UIColor *)color font:(NSInteger)font BColor:(UIColor *)bcolor Radius:(NSInteger)radius MasksToBounds:(BOOL)masksToBounds;
@end

@interface UIImageView (QuickControl)
//快速创建imageView
+(id)imageViewWithFrame:(CGRect)frame
                  image:(NSString *)image;
@end
@interface UITextField (QuickControl)
//快速创建imageView
+(id)textField:(CGRect)frame withPlaceholder:(NSString *)placeholder withLeftViewTitle:(NSString *)title withLeftViewTitleColor:(UIColor *)titleColor withLeftFont:(float)fontSize withLeftViewWidth:(float)width withDelegate:(id)target;
@end

@interface UIView (QuickControl)
+ (id)viewWithFrame:(CGRect)frame bgcolor:(UIColor *)color;
//可以为任何view设置圆角
-(void)setCornerRadius:(float)radius;
//可以为任何View设置边框大小及颜色
- (void)setBorderWidth:(float)width BorderColor:(UIColor *)color;

@end


@interface QuickControl : NSObject

//判断系统版本
+(int)osVersion;


@end
