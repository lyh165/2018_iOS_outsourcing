//
//  BaseViewController.h
//  YouLX
//
//  Created by king on 15/12/12.
//  Copyright © 2015年 feiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic,strong)UIView *navView;
@property (nonatomic,strong)UIImageView *backImageView;
//按钮
@property (nonatomic,strong)MyPicButton *backButton;
@property (nonatomic,strong)MyPicButton *rightButton;
@property (nonatomic,strong)MyPicButton *otherButton;
//标题
@property (nonatomic,strong)UIImageView *titleView;
@property (nonatomic,strong)UILabel *titleLabel;

//导航栏背景图片
@property (nonatomic,strong)NSString *navImage;

//其他按钮
@property (nonatomic,strong)UIButton *button;

//自定义提示框
- (void)showTipView:(NSString *)tipStr;
//------默认的右边按钮-------
- (void)showRightBtn;
//------自定义的右边按钮(图片)-------
- (void)showRightBtn:(CGRect)rightBtnFrame withImage:(NSString *)imageName withImageWidth:(float)imageWidth;
//------自定义的右边按钮(文字)-------
- (void)showRightBtn:(CGRect)rightBtnFrame withFont:(UIFont *)font withTitle:(NSString *)title withTitleColor:(UIColor *)titleColor;
//------默认的返回按钮-------
- (void)showBackBtn;
//------自定义的返回按钮(图片)-------
- (void)showBackBtn:(CGRect)rightBtnFrame withImage:(NSString *)imageName withImageWidth:(float)imageWidth;
//------自定义的返回按钮(文字)-------
- (void)showBackBtn:(CGRect)rightBtnFrame withFont:(UIFont *)font withTitle:(NSString *)title withTitleColor:(UIColor *)titleColor;
//------默认的其他按钮-------
- (void)showOtherBtn;



- (id)buttonWithView:(UIView *)view title:(NSString *)title Cgrect:(CGRect)rect bol:(BOOL)bol color:(UIColor *)color Radius:(NSInteger)radius FontSize:(NSInteger)fontSize;

//按钮事件
- (void)navRightBtnClick:(UIButton *)button;
- (void)backClick:(UIButton *)button;
- (void)navOtherBtnClick:(UIButton *)button;




@end
