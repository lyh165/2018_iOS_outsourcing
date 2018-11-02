//
//  BaseViewController.m
//  YouLX
//
//  Created by king on 15/12/12.
//  Copyright © 2015年 feiwei. All rights reserved.
//

#import "BaseViewController.h"
#import "TabBarViewController.h"
#import "AppDelegate.h"
//#import <IQKeyboardManager/IQKeyboardManager.h>
#import "IQKeyboardReturnKeyHandler.h"

@interface BaseViewController ()
//加载视图
@property (nonatomic,strong)UILabel *tipLabel;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;
@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.toolbar.hidden = YES;
    
//    TabBarViewController *tabVC = (TabBarViewController *)self.tabBarController;
//    if (self.navigationController.viewControllers.count > 1) {
//        [tabVC showTabbar:NO];
//    }else {
//        [tabVC showTabbar:YES];
//    }
#pragma mark ==判断token是否已经过期
//    if (![self isKindOfClass:[LoginViewController class]]) {
//        NSString *token = [UserDefaults objectForKey:@"tokenContent"];
//        if (token != NULL) {
//            NSDictionary *params = @{@"tokenContent":[UserDefaults objectForKey:@"tokenContent"]};
//            [NetRequest getDataWithUrlString:CHECK_TOKEN_URL withParams:params success:^(id data) {
//                if ([data[@"message"] intValue] == 1) {
//                    
//                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您"
//                                                          @"的帐号在别的设备上登录，您被迫下线！" preferredStyle:UIAlertControllerStyleAlert];
//                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:0 handler:^(UIAlertAction * _Nonnull action) {
//                        [UserDefaults removeObjectForKey:@"tokenContent"];
//                        double delayInSeconds = 0.0;
//                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                            LoginViewController *loginVC = [[LoginViewController alloc] init];
//                            AppDelegateInstance.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:loginVC];
//                        });
//
//                    }];
//                    [alertController addAction:cancelAction];
//                    [self presentViewController:alertController animated:YES completion:nil];
//                    
//                }
//            } fail:^(NSString *errorDes) {
////                NSLog(@"验证失败");
//            }];
//        }
//        
//    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavView];
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    //    self.returnKeyHandler.toolbarManageBehaviour = IQAutoToolbarBySubviews;
}

- (id)buttonWithView:(UIView *)view title:(NSString *)title Cgrect:(CGRect)rect bol:(BOOL)bol color:(UIColor *)color Radius:(NSInteger)radius FontSize:(NSInteger)fontSize{
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:title forState:(UIControlStateNormal)];
    self.button.backgroundColor = color;
    self.button.frame = rect;
    self.button.layer.cornerRadius = radius;
    self.button.layer.masksToBounds = bol;
    self.button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [view addSubview:self.button];
    
    return _button;
    
    
}

- (void)initNavView{
    //创建主视图包含基础视图
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-0)];
    //创建背景视图
    _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, backView.frame.size.height)];
    _backImageView.backgroundColor = background_color;
    [backView addSubview:_backImageView];
    [self.view addSubview:backView];
    
    //自定义导航栏视图
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    //添加导航栏背景视图
    _imageView = [UIImageView imageViewWithFrame:CGRectMake(0, 0, screen_width, 64) image:@""];
    _navView.backgroundColor = theme_color;
    [_navView addSubview:_imageView];
    
//    _navView.backgroundColor = navBar_color;
    //标题视图
    _titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    _titleView.frame = CGRectMake(0, 0, 30, 24);
    _titleView.center = CGPointMake(screen_width/2, 20+22);
    [_navView addSubview:_titleView];
    //标题名
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((screen_width-200)/2, 24, 200, 36)];
    _titleLabel.textAlignment = 1;
    _titleLabel.font = [UIFont systemFontOfSize:20.0f];
    _titleLabel.textColor = [UIColor whiteColor];
    [_navView addSubview:_titleLabel];
    [self.view addSubview:_navView];
    
    //输入提示框
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screen_width, 30)];
    _tipLabel.textColor = [UIColor whiteColor];
    _tipLabel.backgroundColor = color(0, 0, 0, 0.7);
    _tipLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    _tipLabel.layer.cornerRadius = 5;
    _tipLabel.clipsToBounds = YES;
    _tipLabel.textAlignment = 1;
}

- (void)setNavImage:(NSString *)navImage{
    
    if (_navImage != navImage) {
        _navImage = navImage;
    }
    self.imageView.image = [UIImage imageNamed:navImage];
    
}

#pragma mark -- 创建控件
//------默认的右边按钮-------
- (void)showRightBtn {
    if (_rightButton == nil) {
        //基础控件的初始化
        _rightButton = [MyPicButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setFrame:CGRectMake(screen_width-45, 24, 40, 36)];
        [_rightButton setBtnViewWithImage:@"" withImageWidth:30 withTitle:@"" withTitleColor:[UIColor whiteColor] withFont:systemFont(13.0f)];
        [_rightButton addTarget:self action:@selector(navRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:_rightButton];
    }
}
//------自定义的右边按钮(图片)-------
- (void)showRightBtn:(CGRect)rightBtnFrame withImage:(NSString *)imageName withImageWidth:(float)imageWidth{
    if (_rightButton == nil) {
        //基础控件的初始化
        _rightButton = [MyPicButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setFrame:rightBtnFrame];
        [_rightButton setBtnViewWithImage:imageName withImageWidth:imageWidth withTitle:@"" withTitleColor:[UIColor whiteColor] withFont:systemFont(14.0f)];
        [_rightButton addTarget:self action:@selector(navRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:_rightButton];
    }
}
//------自定义的右边按钮(文字)-------
- (void)showRightBtn:(CGRect)rightBtnFrame withFont:(UIFont *)font withTitle:(NSString *)title withTitleColor:(UIColor *)titleColor{
    if (_rightButton == nil) {
        //基础控件的初始化
        _rightButton = [MyPicButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setFrame:rightBtnFrame];
        [_rightButton setBtnViewWithImage:@"" withImageWidth:1 withTitle:title withTitleColor:titleColor withFont:font];
//        _rightButton.picPlacement = 2;
        [_rightButton setOnlyText];
        [_rightButton addTarget:self action:@selector(navRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:_rightButton];
    }
}

//当push的时候显示返回按钮
//------默认的返回按钮-------
- (void)showBackBtn {
    if (_backButton == nil) {
        _backButton = [MyPicButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(10, 24, 90, 36);
        _backButton.imageDistant = 0;
        _backButton.txtImgDistant = 3;
        [_backButton setBtnViewWithImage:@"back" withImageWidth:20 withTitle:@"返回" withTitleColor:[UIColor whiteColor] withFont:systemFont(16.0f)];
        
        [_backButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:_backButton];
    }
    //    _titleView.left = _backButton.right;
}
//------自定义的返回按钮(图片)-------
- (void)showBackBtn:(CGRect)rightBtnFrame withImage:(NSString *)imageName withImageWidth:(float)imageWidth {
    if (_backButton == nil) {
        //基础控件的初始化
        _backButton = [MyPicButton buttonWithType:UIButtonTypeCustom];
        [_backButton setFrame:rightBtnFrame];
        [_backButton setBtnViewWithImage:imageName withImageWidth:imageWidth withTitle:@"" withTitleColor:[UIColor whiteColor] withFont:systemFont(17.0f)];
        [_backButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:_backButton];
    }
}
//------自定义的返回按钮(文字)-------
- (void)showBackBtn:(CGRect)rightBtnFrame withFont:(UIFont *)font withTitle:(NSString *)title withTitleColor:(UIColor *)titleColor {
    if (_backButton == nil) {
        //基础控件的初始化
        _backButton = [MyPicButton buttonWithType:UIButtonTypeCustom];
        [_backButton setFrame:rightBtnFrame];
        [_backButton setBtnViewWithImage:@"" withImageWidth:1 withTitle:title withTitleColor:titleColor withFont:font];
        [_backButton setOnlyText];
        [_backButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:_backButton];
    }
}
//------默认的其他按钮-------
- (void)showOtherBtn {
    if (_otherButton == nil) {
        //基础控件的初始化
        _otherButton = [MyPicButton buttonWithType:UIButtonTypeCustom];
        [_otherButton setFrame:CGRectMake(screen_width-80, 27, 30, 30)];
        [_otherButton setBtnViewWithImage:@"" withImageWidth:30 withTitle:@"" withTitleColor:[UIColor whiteColor] withFont:systemFont(17.0f)];
        [_otherButton addTarget:self action:@selector(navOtherBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:_otherButton];
    }
}

#pragma 提示框
- (void)showTipView:(NSString *)tipStr {
    if (![_tipLabel superview]) {
        [_tipLabel removeFromSuperview];
        _tipLabel.text = tipStr;
        CGSize size = [_tipLabel sizeThatFits:CGSizeMake(MAXFLOAT, 30)];
        _tipLabel.width = size.width+30;
        _tipLabel.center = CGPointMake(screen_width/2, screen_height/2);
        [self.view addSubview:_tipLabel];
    }
    [_tipLabel performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:2];
}

#pragma 导航栏按钮事件
//左边
- (void)backClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
//右边
- (void)navRightBtnClick:(UIButton *)button {
    
}
//其他
- (void)navOtherBtnClick:(UIButton *)button {
    
}


//实现点击背景则回收键盘功能
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
