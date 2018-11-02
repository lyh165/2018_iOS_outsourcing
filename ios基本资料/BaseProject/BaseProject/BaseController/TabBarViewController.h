//
//  TabBarViewController.h
//  YouLX
//
//  Created by king on 15/12/12.
//  Copyright © 2015年 feiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarViewController : UITabBarController<UINavigationControllerDelegate>

@property (nonatomic,strong)UIView *tabView;
- (void)btnClick:(MyPicButton *)button;
//是否隐藏tabbar
- (void)showTabbar:(BOOL)show;

@property(nonatomic,strong) NSDictionary *dict;

@end
