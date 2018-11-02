//
//  NetRequest.h
//  CustomHUD
//
//  Created by feiwei on 15/11/23.
//  Copyright © 2015年 feiwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYFactoryManager.h"
#import "AFNetworking.h"
typedef void (^Locatlock)(id);
typedef void(^SuccessBlock)(id data);
typedef void(^FailBlock)(NSError *errorDes);
@interface NetRequest : NSObject

@property (nonatomic,copy)Locatlock block;

/**
 *urlString：数据请求的接口
 *type：0为get请求，1为post请求
 *params：数据请求的参数
 *successBlock：数据请求成功
 *failBlock：数据请求失败
 */
+ (void)requestWithUrlString:(NSString *)urlString type:(NSInteger)type withParams:(NSDictionary *)params success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
/**
 *urlString：数据请求的接口
 *params：数据请求的参数
 *key：文件名
 *image：上传的图片
 *successBlock：数据请求成功
 *failBlock：数据请求失败
 */
+ (void)postImageDataWithUrlString:(NSString *)urlString withParams:(NSDictionary *)params picDataKey:(NSString *)key image:(UIImage *)image success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

@end
