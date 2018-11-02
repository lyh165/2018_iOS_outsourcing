//
//  BaseTableView.h
//  NewWeibo
//
//  Created by qf on 15/9/16.
//  Copyright (c) 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
@protocol tableViewEventDelegate <NSObject>
@optional
//上拉
- (void)pullUp:(UITableView *)tableView;
//下拖
- (void)pullDown:(UITableView *)tableView;
//选中
- (void)didSelectTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;
//滚动
- (void)tableViewDidScroll:(UIScrollView *)tableView;

@end
@interface BaseTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign)BOOL isDrag; //是否可拖拽
@property (nonatomic,assign)BOOL noTip;
@property (nonatomic,retain)NSArray *data;      //为tableView提供数据
@property (nonatomic,retain)NSMutableArray *daArray;
@property (nonatomic,assign)BOOL isDown;//是否是下拉
@property (nonatomic,strong)NSString *page;
@property (nonatomic,strong)NSMutableArray *mArr;
@property (nonatomic,weak)id<tableViewEventDelegate> eventDelegate;
- (void)_initCon;
- (void)endFreshing;

@end
