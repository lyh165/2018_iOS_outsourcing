//
//  QuickControl.m
//  FreeLimit1413
//
//  Created by mac on 14-6-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "QuickControl.h"

@implementation UILabel (QuickControl)
//添加快速创建的方法
+(id)labelWithFrame:(CGRect)frame text:(NSString *)text font:(float)fontSize textColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
    CGFloat w = [MYFactoryManager widthForString:text fontSize:fontSize andHeight:frame.size.height];
    if (w > label.frame.size.width) {
        label.width = w;
    }
    return label;
}
//添加快速创建的方法
+(id)DelectLabelWithFrame:(CGRect)frame text:(NSString *)text font:(float)fontSize textColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
    //删除线
    UIView *lints = [[UIView alloc] initWithFrame:CGRectZero];
    lints.backgroundColor = [UIColor grayColor];
    [label addSubview:lints];
    [lints mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(label);
        make.left.equalTo(label);
        make.center.equalTo(label);
        make.height.mas_equalTo(1);
    }];
    return label;
}
@end

@implementation UIButton (QuickControl)

//快速创建按钮的方法
+(id)buttonWithFrame:(CGRect)frame
               title:(NSString *)title
               image:(NSString *)image
              target:(id)target
              action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
//快速创建按钮的方法
+(id)buttonWithFrame:(CGRect)frame
               title:(NSString *)title
               image:(NSString *)image
              target:(id)target
              action:(SEL)action Textcolor:(UIColor *)color font:(NSInteger)font BColor:(UIColor *)bcolor Radius:(NSInteger)radius MasksToBounds:(BOOL)masksToBounds
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = bcolor;
    button.layer.cornerRadius = radius;
    button.layer.masksToBounds = masksToBounds;
    return button;
}

@end

@implementation UIImageView (QuickControl)
//快速创建imageView
+(id)imageViewWithFrame:(CGRect)frame
                  image:(NSString *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    return imageView;
}
@end

@implementation UITextField (QuickControl)
//快速创建textField
+(id)textField:(CGRect)frame withPlaceholder:(NSString *)placeholder withLeftViewTitle:(NSString *)title withLeftViewTitleColor:(UIColor *)titleColor withLeftFont:(float)fontSize withLeftViewWidth:(float)width withDelegate:(id)target{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.font = [UIFont systemFontOfSize:fontSize];
    textField.backgroundColor = [UIColor whiteColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.autocapitalizationType = YES;
    textField.minimumFontSize = 10;
    textField.placeholder = placeholder;
    textField.delegate = target;
    CGFloat ww = [MYFactoryManager widthForString:title fontSize:fontSize andHeight:frame.size.height]+10;
    if (ww > width) {
        width = ww;
    }
    UILabel *leftLabel = [UILabel labelWithFrame:CGRectMake(0, 0, width, frame.size.height) text:title font:fontSize textColor:titleColor];
    leftLabel.textAlignment = 1;
    textField.leftView = leftLabel;
    textField.textColor = title_color;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    return textField;
}
@end

@implementation UIView (QuickControl)
+ (id)viewWithFrame:(CGRect)frame bgcolor:(UIColor *)color{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}
//可以为任何view设置圆角
-(void)setCornerRadius:(float)radius
{
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
}

- (void)setBorderWidth:(float)width BorderColor:(UIColor *)color{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

@end

@implementation QuickControl
//判断系统版本
+(int)osVersion
{
    //使用UIDevice设别类获取版本, 名字.....
    return [[[UIDevice currentDevice] systemVersion] intValue];
}
@end
