//
//  LYH_SuperBargain_ViewController.m
//  BaseProject
//
//  Created by lee on 2018/11/2.
//  Copyright © 2018年 feiwei. All rights reserved.
//

#import "LYH_SuperBargain_ViewController.h"
#import "LYH_View_SearchBar.h"  // 用于设置自定义高度的searchbar
#import "SuperBargain_noupons_Cell.h"   // 没有优惠券的cell
#import "SuperBargain_Model.h"          // 推送模型
@interface LYH_SuperBargain_ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet LYH_View_SearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


// 关信属性
@property (strong,nonatomic) NSMutableArray *temp_dataArr;

@end

@implementation LYH_SuperBargain_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTitle:@"58手艺"
           titleColor:[UIColor whiteColor]
             NavColor:[UIColor redColor]
         fontWithName:@"Helvetica-Bold"
             fontSize:17];
  
    // 默认的search 不能设置高度 。所以只能透过contentInset去设置
    self.searchBar.contentInset = UIEdgeInsetsMake(4, 0, 4, 0);
    [self customMethod_viewInit];

}

#pragma mark - customMethod start
/**
 view开始的初始化
 */
- (void)customMethod_viewInit
{
    // 1.设置 列表控件的 数据源和代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
#warning 设置测试数据
    // 2.注册xib的接口
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SuperBargain_noupons_Cell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SuperBargain_noupons_Cell class])];
    
    // 添加3条不一样的数据 显示cell的不同
    self.temp_dataArr = [NSMutableArray array];
    SuperBargain_Model *model1 = [SuperBargain_Model new];
    model1.homeIdenx = HOMEidenx_noupons;
    for (int i = 0; i < 1; i++) {
        [self.temp_dataArr addObject:model1];
    }
    
    
    
}
#pragma mark  customMethod end

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.temp_dataArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SuperBargain_Model *model = [self.temp_dataArr objectAtIndex:indexPath.row];
    
    /**
     多个cell显示 参考 https://www.jb51.net/article/120791.htm
     https://www.2cto.com/kf/201606/519041.html
     */
    
    // 根据服务类型去显示不一样的cell
        SuperBargain_noupons_Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SuperBargain_noupons_Cell class])];
        return cell;

    
    
    
}
#pragma mark TabviewDataSource end

#pragma mark - TabviewDataDelegate start
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"deselectRowAtIndexPath");
}

#pragma mark TabviewDataDelegate end

@end
