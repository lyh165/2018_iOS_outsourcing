//
//  ConsumerOrders_TableViewDataSource.m
//  BaseProject
//
//  Created by liyuhong165 on 2018/11/5.
//  Copyright © 2018年 feiwei. All rights reserved.
//

#import "ConsumerOrders_TableViewDataSource.h"
#import "ConsumerOrders_NoService_Cell.h"   // 未服务的cell
#import "ConsumerOrders_HasService_Cell.h"  // 已服务的cell

@implementation ConsumerOrders_TableViewDataSource

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.modelArray.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentiferAtIndexPath:indexPath]];
//    if (!cell) {
//        Class cls = [self cellClassAtIndexPath:indexPath];
//        cell = [[cls alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self cellIdentiferAtIndexPath:indexPath]];
//    }
//    cell.item = [self itemAtIndexPath:indexPath];
//    return cell;
//}
//
//- (Class)cellClassAtIndexPath:(NSIndexPath *)indexPath{
//    CDZTableviewItem *item = [self itemAtIndexPath:indexPath];
//    switch (item.type) {
//        case typeA:{
//            return [CDZTypeACell class];
//        }
//            break;
//        case typeB:{
//            return [CDZTypeBCell class];
//        }
//            break;
//    }
//}
//
//- (CDZTableviewItem *)itemAtIndexPath:(NSIndexPath *)indexPath{
//    return self.itemsArray[indexPath.row];
//}
//
//- (NSString *)cellIdentiferAtIndexPath:(NSIndexPath *)indexPath{
//    return NSStringFromClass([self cellClassAtIndexPath:indexPath]);
//}

@end
