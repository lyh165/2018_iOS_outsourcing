//
//  SuperBargain_Model.h
//  BaseProject
//
//  Created by liyuhong165 on 2018/11/7.
//  Copyright © 2018年 feiwei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    
    HOMEidenx_noupons,   // 没有优惠券
    HOMEidenx_havE_noupons, // 有优惠券
    
} HOMEidenx;

@interface SuperBargain_Model : NSObject
@property (nonatomic,assign) HOMEidenx homeIdenx;

@end
