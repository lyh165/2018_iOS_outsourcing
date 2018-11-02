#import "LYH_BaseXib_ViewController.h"
@interface LYH_BaseXib_ViewController ()
@end

@implementation LYH_BaseXib_ViewController
- (void)viewDidLoad
{
    // 视图加载调用,只会调用一次
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;  // 防止xib往上偏移64的点
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // 收到内存警告
}
- (void)setNavTitle:(NSString *)title
{
        self.navigationItem.title = title;
}
- (void)setNavColor:(UIColor *)color
{
    self.navigationController.navigationBar.barTintColor = color;
}

- (void)setNavTitleColor:(NSString *)navTitleColortitleColor
{
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:navTitleColortitleColor,
       NSFontAttributeName :[UIFont fontWithName:@"AppleGothic" size:17]}];
}
// Helvetica-Bold
- (void)setNavTitle:(NSString *)title
         titleColor:(UIColor *)titleColor
           NavColor:(UIColor *)navColor
       fontWithName:(NSString *)fontName
           fontSize:(CGFloat)fontSize;
{
    [self setNavTitle:title];
    [self setNavColor:navColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
                                    @{NSForegroundColorAttributeName:titleColor,
                                                NSFontAttributeName :[UIFont fontWithName:fontName size:fontSize]}];
}



@end
