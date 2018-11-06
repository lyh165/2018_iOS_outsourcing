//
//  ConsumerOrders_ViewController.m
//  BaseProject
//
//  Created by liyuhong165 on 2018/11/5.
//  Copyright © 2018年 feiwei. All rights reserved.
//

#import "ConsumerOrders_ViewController.h"
#import "ConsumerOrders_Model.h"
// cell
#import "ConsumerOrders_NoService_Cell.h"       // 未服务
#import "ConsumerOrders_HasService_Cell.h"      // 已服务
#import "ConsumerOrders_Refund_Cell.h"          // 已退款

@interface ConsumerOrders_ViewController () <UITableViewDataSource,UITableViewDelegate>
// 控件属性
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 属性
@property (strong,nonatomic) NSMutableArray *temp_dataArr;
@end

@implementation ConsumerOrders_ViewController

#pragma mark - view cilce start
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消费订单";
    [self customMethod_viewInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark  view cilce end
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ConsumerOrders_NoService_Cell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ConsumerOrders_NoService_Cell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ConsumerOrders_HasService_Cell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ConsumerOrders_HasService_Cell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ConsumerOrders_Refund_Cell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ConsumerOrders_Refund_Cell class])];

    // 添加3条不一样的数据 显示cell的不同
    self.temp_dataArr = [NSMutableArray array];
    ConsumerOrders_Model *model1 = [ConsumerOrders_Model new];
    model1.orderServerType = ORDERServerType_noServer;
    ConsumerOrders_Model *model2 = [ConsumerOrders_Model new];
    model2.orderServerType = ORDERServerType_hasService;
    ConsumerOrders_Model *model3 = [ConsumerOrders_Model new];
    model3.orderServerType = ORDERServerType_hasRefund;
    for (int i = 0; i < 1; i++) {
        [self.temp_dataArr addObject:model1];
        [self.temp_dataArr addObject:model2];
        [self.temp_dataArr addObject:model3];
    }
  
    

}
#pragma mark  customMethod end


#pragma mark - UISegmentedControl Delegate start
- (IBAction)selected:(UISegmentedControl *)sgm {
    switch (sgm.selectedSegmentIndex) {
        case 0:
        {
            NSLog(@"%s 选择了全部",__FUNCTION__);
        }
            break;
        case 1:
        {
            NSLog(@"%s 选择了未服务",__FUNCTION__);
        }
            break;

        default:
            break;
    }
}

#pragma mark  UISegmentedControl Delegate end


#pragma mark - TabviewDataSource start

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.temp_dataArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConsumerOrders_Model *model = [self.temp_dataArr objectAtIndex:indexPath.row];
    
    /**
     多个cell显示 参考 https://www.jb51.net/article/120791.htm
     https://www.2cto.com/kf/201606/519041.html
     */
    
    // 根据服务类型去显示不一样的cell
    if (model.orderServerType == ORDERServerType_noServer) {
        ConsumerOrders_NoService_Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConsumerOrders_NoService_Cell class])];
        return cell;
    }
    else if (model.orderServerType == ORDERServerType_hasService) {
        ConsumerOrders_HasService_Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConsumerOrders_HasService_Cell class])];

        return cell;
    }
    else {
        ConsumerOrders_Refund_Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConsumerOrders_Refund_Cell class])];

        return cell;
    }
        
   
    
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
