//
//  ConsumerOrders_TableViewDataSource.h
//  BaseProject
//
//  Created by liyuhong165 on 2018/11/5.
//  Copyright © 2018年 feiwei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ConsumerOrders_Model;
@interface ConsumerOrders_TableViewDataSource : NSObject<UITableViewDataSource>

@property (nonatomic,strong) NSArray *modelArray;

- (ConsumerOrders_Model *)itemAtIndexPath:(NSIndexPath *)indexPath;
- (Class)cellClassAtIndexPath:(NSIndexPath *)indexPath;

@end


/**
 多个cell显示 参考 https://www.jb51.net/article/120791.htm
 tableview的数据源
 */
