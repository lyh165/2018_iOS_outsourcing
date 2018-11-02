//
//  BaseTableViewCell.h
//  CarSpider
//
//  Created by fwios001 on 15/11/24.
//  Copyright © 2015年 fwios001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

- (void)_initView;
- (void)threadWithView:(UIView *)view;
- (MyPicButton *)buttonWithFrame:(CGRect)rect title:(NSString *)title font:(NSInteger)font view:(UIView *)view color:(UIColor *)color;
@end
