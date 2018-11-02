//
//  TabBarViewController.m
//  YouLX
//
//  Created by king on 15/12/12.
//  Copyright © 2015年 feiwei. All rights reserved.
//

#import "TabBarViewController.h"
#import "LYH_SuperBargain_ViewController.h" // 超划算
#import "LYH_TradeCircle_ViewController.h"  // 手艺圈
#import "LYH_MyViewController.h"            // 我的

@interface TabBarViewController ()

@end

@implementation TabBarViewController
{
    MyPicButton *lastBtn;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    if (self.viewControllers.count > 0) {
        return;
    }
    //设置状态栏的颜色为白色
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self initTabBar];
    [self saveNavCon];
    //tabbar
}

- (void)saveNavCon{
    LYH_SuperBargain_ViewController *superBargainVC = [[LYH_SuperBargain_ViewController alloc]init];
    LYH_TradeCircle_ViewController *tradeCircleVC = [[LYH_TradeCircle_ViewController alloc]init];
    LYH_MyViewController *myVC = [[LYH_MyViewController alloc]init];
    NSArray *viewArr = [[NSArray alloc] initWithObjects:superBargainVC,tradeCircleVC,myVC, nil];
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:viewArr.count];
    for (UIViewController *vc in viewArr) {
        UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:vc];
        navCon.delegate = self;
        [mArray addObject:navCon];
    }
    self.viewControllers = mArray;
    self.selectedIndex = 0;

}

- (void)initTabBar{
    _tabView = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height-49, screen_height, 49)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 49)];
    imageView.backgroundColor = color(242, 242, 242, 1);
    [_tabView addSubview:imageView];
    //细线
    UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, screen_width, 0.5)];
    sepLine.backgroundColor = color(218, 218, 218, 1);
    [_tabView addSubview:sepLine];
    
    NSArray *titleArray,*picArray,*highArray;
    
    titleArray = @[@"超划算",@"手艺圈",@"我的"];
    picArray = @[@"nav_chaob",@"nav_shouyu",@"nav_wode"];
    highArray = @[@"shop_light",@"shouyiquan_light",@"my_light"];
    
    
    float interval = (screen_width-30)/titleArray.count;
    for (int i=0; i<titleArray.count; i++) {
        MyPicButton *button = [MyPicButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15+interval*i, 1,interval, 45);
        [button setBtnViewWithImage:[picArray objectAtIndex:i] withImageWidth:21 withTitle:[titleArray objectAtIndex:i] withTitleColor:color(0, 0, 0, 0.1) withFont:systemFont(12.0f)];
        button.picPlacement = 1;
        button.imageDistant = 3;
        [button setBtnselectImage:[highArray objectAtIndex:i]withselectTitleColor:theme_color];
        button.tag = 100+i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tabView addSubview:button];
        if (i == 0) {
            button.myBtnSelected = YES;
            lastBtn = button;
        }
    }
    [self.view addSubview:_tabView];
}

#pragma 标签栏按钮
- (void)btnClick:(MyPicButton *)button{
    if (button != lastBtn) {
        button.myBtnSelected = !button.myBtnSelected;
        lastBtn.myBtnSelected = NO;
        lastBtn = button;
    }
    //计算按钮间隔
    self.selectedIndex = button.tag - 100;
}

#pragma UINavigationDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //计算导航栏控制器子控制器个数
    int count = (int)navigationController.viewControllers.count;
    if (count == 2) {
        [self showTabbar:NO];
    }else if(count == 1) {
        [self showTabbar:YES];
    }
}

//是否隐藏tabbar
- (void)showTabbar:(BOOL)show
{
    [UIView animateWithDuration:0.2 animations:^{
        if (show) {
            _tabView.frame = CGRectMake(0, screen_height - 49 , screen_width, 49);
        }else{
            _tabView.frame = CGRectMake(- screen_width, screen_height - 49 , screen_width, 49);
        }
    }];
}
    

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
