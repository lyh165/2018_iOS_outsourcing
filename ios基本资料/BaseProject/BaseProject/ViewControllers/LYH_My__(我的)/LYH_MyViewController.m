//
//  LYH_MyViewController.m
//  BaseProject
//
//  Created by lee on 2018/11/2.
//  Copyright © 2018年 feiwei. All rights reserved.
//

#import "LYH_MyViewController.h"

// 我的里面的子控制器 SubVC
#import "ConsumerOrders_ViewController.h"

@interface LYH_MyViewController ()
<UITableViewDataSource,
UITableViewDelegate
>
{
    UIImageView *navBarHairlineImageView;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableview;

@end

@implementation LYH_MyViewController
#pragma mark - view cilce
// 即将进入视图
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    navBarHairlineImageView.hidden = YES;
}
// 即将销毁视图
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customMethod_viewInit];
//    self.navigationController.TR = NO;
}

#pragma mark - customMethod start
/**
 view开始的初始化
 */
- (void)customMethod_viewInit
{
    // 1.设置导航栏
    [self setNavTitle:@"我的"
           titleColor:[UIColor whiteColor]
             NavColor:[UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1]
         fontWithName:@"Helvetica-Bold"
             fontSize:17];
    
    // 2.隐藏导航栏的黑线
    navBarHairlineImageView = [self customMethod_findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    // 3.设置tableview的每个分区的间距
    self.myTableview.sectionHeaderHeight = 10.0;
}
- (UIImageView *)customMethod_findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self customMethod_findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

#pragma mark customMethod end

#pragma mark - btnAction start
// 头部
- (IBAction)go2SettingsVC:(UIButton *)btn
{
    NSLog(@"%s",__FUNCTION__);
}

// 中心部分
/*
 
 奖励                 reward
 钱包                 wallet
 消息                 message
 */
- (IBAction)go2Reward:(UIButton *)btn
{
    NSLog(@"%s",__FUNCTION__);
}
- (IBAction)go2Wallet:(UIButton *)btn
{
    NSLog(@"%s",__FUNCTION__);
}
- (IBAction)go2Message:(UIButton *)btn
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 发布管理              Release management
 接单                 Receipt
 我的主页              My home page

 手艺圈               Craftsmanship
 企业号               Enterprise number
 手艺人信息            Craftsman information
 */
- (IBAction)go2ReleaseManagement:(UIButton *)btn
{
    NSLog(@"%s",__FUNCTION__);
}
- (IBAction)go2Receipt:(UIButton *)btn
{
    NSLog(@"%s",__FUNCTION__);
}
- (IBAction)go2MyHomePage:(UIButton *)btn
{
    NSLog(@"%s",__FUNCTION__);
}
- (IBAction)go2Craftsmanship:(UIButton *)btn
{
    NSLog(@"%s",__FUNCTION__);
}
- (IBAction)go2EnterpriseNumber:(UIButton *)btn
{
    NSLog(@"%s",__FUNCTION__);
}
- (IBAction)go2CraftsmanInformation:(UIButton *)btn
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 收藏                Collection
 消费订单             Consumer order
 我要投诉              I want to complain
 */
- (IBAction)go2Collection:(UIButton *)btn
{
    NSLog(@"%s",__FUNCTION__);
}
- (IBAction)go2ConsumerOrder:(UIButton *)btn
{
    NSLog(@"%s",__FUNCTION__);
    ConsumerOrders_ViewController *vc = [[ConsumerOrders_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)go2IWantToComplain:(UIButton *)btn
{
    NSLog(@"%s",__FUNCTION__);
}

// 底部 tableview didSelectRowAtIndexPath
#pragma mark  btnAction end

#pragma mark - TabviewDataSource start

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    cell.textLabel.text = @"关于超级手艺";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark TabviewDataSource end

#pragma mark - TabviewDataDelegate start
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"关于58手艺");
}
/**
 每个分区之间的高度间隔
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0 ;
}
#pragma mark TabviewDataDelegate end

@end
