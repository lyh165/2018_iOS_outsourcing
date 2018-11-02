//
//  BaseTableView.m
//  NewWeibo
//
//  Created by qf on 15/9/16.
//  Copyright (c) 2015年 qf. All rights reserved.
//
#import "BaseTableView.h"
#import "AppDelegate.h"

@implementation BaseTableView
{
    UIView *_tipView;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initCon];
    }
    return self;
}

- (void)_initCon{
    self.delegate = self;
    self.dataSource = self;
    //初始设置为不可拖拽
    self.isDrag = NO;
    self.separatorColor = color(0, 0, 0, 0.1);
    self.backgroundColor = [UIColor clearColor];
    self.daArray = [[NSMutableArray alloc]init];
    _isDown = NO;
    self.page = @"1";
    _mArr = [[NSMutableArray alloc] init];
    self.tableFooterView = [UIView new];
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
}

- (void)setIsDrag:(BOOL)isDrag {
    if (_isDrag != isDrag) {
        _isDrag = isDrag;
    }
    //是否可拖拽，如果可以才在此处创建刷新视图
    if (_isDrag) {
        [self createRefreshView];
    }
}

- (void)createRefreshView{
    
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"下拉刷新");
        _page = @"1";
        [_mArr removeAllObjects];
        _isDown = YES;
        if ([self.eventDelegate respondsToSelector:@selector(pullDown:)]) {
            [self.eventDelegate pullDown:self];
        }
    }];
    
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _isDown = NO;
        _page = [NSString stringWithFormat:@"%d",[_page intValue]+1];
        if ([self.eventDelegate respondsToSelector:@selector(pullUp:)]) {
            [self.eventDelegate pullUp:self];
        }
        NSLog(@"上拉刷新");
    }];
    
    
}



- (void)reloadData {
    [super reloadData];
    if (self.isDrag) {
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
    }
}

- (void)endFreshing {
    if (self.isDrag) {
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
    }
}



- (void)setData:(NSArray *)data {
    if (_data != data) {
        _data = data;
    }
    if (!self.noTip) {
        if (self.data.count == 0) {
            if (_tipView == nil) {
                _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableHeaderView.height, self.width, self.height-self.tableHeaderView.height-self.tableFooterView.height)];
                UILabel *tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
                tipLable.center = CGPointMake(_tipView.width/2, _tipView.height/2);
                tipLable.textColor = [UIColor grayColor];
                tipLable.font = [UIFont boldSystemFontOfSize:16.0f];
                tipLable.text = @"暂无数据";
                [_tipView addSubview:tipLable];
            }
            if (![_tipView superview]) {
                [self addSubview:_tipView];
            }
        }else {
            if ([_tipView superview]) {
                [_tipView removeFromSuperview];
            }
        }

    }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"king";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.eventDelegate respondsToSelector:@selector(didSelectTableView: forIndexPath:)]) {
        [self.eventDelegate didSelectTableView:tableView forIndexPath:indexPath];
    }
    [self deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.eventDelegate respondsToSelector:@selector(tableViewDidScroll:)]) {
        [self.eventDelegate tableViewDidScroll:scrollView];
    }
}



@end
