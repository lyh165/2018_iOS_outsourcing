//
//  ConsumerOrders_Model.h
//  BaseProject
//
//  Created by liyuhong165 on 2018/11/5.
//  Copyright © 2018年 feiwei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    
    ORDERServerType_noServer,   // 未服务
    ORDERServerType_hasService, // 已服务
    ORDERServerType_hasRefund, // 已退款

} ORDERServerType;

@interface ConsumerOrders_Model : NSObject

@property (nonatomic,assign) ORDERServerType orderServerType;

@end
