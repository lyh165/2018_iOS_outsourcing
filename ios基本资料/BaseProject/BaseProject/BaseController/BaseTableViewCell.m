//
//  BaseTableViewCell.m
//  CarSpider
//
//  Created by fwios001 on 15/11/24.
//  Copyright © 2015年 fwios001. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)threadWithView:(UIView *)view{
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0.0f,0.1f);
    view.layer.shadowOpacity = 0.1f;
}
- (MyPicButton *)buttonWithFrame:(CGRect)rect title:(NSString *)title font:(NSInteger)font view:(UIView *)view color:(UIColor *)color{
    
    //基础控件的初始化
    MyPicButton *but = [MyPicButton buttonWithType:UIButtonTypeCustom];
    [but setFrame:rect];
    //    - (void)setBtnViewWithTitle:(NSString *)title withTitleColor:(UIColor *)titleColor withFont:(UIFont *)font;
    
    [but setBtnViewWithImage:@"" withImageWidth:30 withTitle:title withTitleColor:[UIColor whiteColor] withFont:systemFont(font)];
    but.layer.cornerRadius = 5;
    but.layer.masksToBounds = YES;
    [but setBtnViewWithTitle:title withTitleColor:color withFont:[UIFont systemFontOfSize:font]];
    [but.layer setBorderWidth:1.5];
    [but.layer setBorderColor:[color(234, 234, 234, 1) CGColor]];
    [view addSubview:but];
    return but;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    for (UIView *subView in self.subviews) {
        if ([NSStringFromClass([subView class])isEqualToString:@"UITableViewCellDeleteConfirmationView"]) {
            
            UIView *view = (UIView *)[subView.subviews firstObject];
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((view.frame.size.width - 28)/2, (view.frame.size.height - 28)/2, 28, 28)];
            imageV.image = [UIImage imageNamed:@"删除"];
            
            [view addSubview:imageV];
            
            
            view.backgroundColor = color(231, 231, 231, 1);
            
        }
    }
}

- (void)_initView{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
