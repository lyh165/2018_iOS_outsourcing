#import <UIKit/UIKit.h>

@interface LYH_BaseXib_ViewController : UIViewController
// 都是給最高级调用
- (void)setNavColor:(UIColor *)color;
- (void)setNavTitle:(NSString *)title;
- (void)setNavTitleColor:(NSString *)navTitleColortitleColor;
/**
 设置导航栏的样式

 @param title 导航栏标题
 @param titleColor 导航栏标题的颜色
 @param navColor 导航栏颜色
 @param fontName 导航栏标题字体样式
 @param fontSize 导航栏标题字体大小
 */
- (void)setNavTitle:(NSString *)title
         titleColor:(UIColor *)titleColor
           NavColor:(UIColor *)navColor
       fontWithName:(NSString *)fontName
           fontSize:(CGFloat)fontSize;
@end
