//
//  NetRequest.m
//  CustomHUD
//
//  Created by feiwei on 15/11/23.
//  Copyright © 2015年 feiwei. All rights reserved.
//

#import "NetRequest.h"
#import "AppDelegate.h"
#define BAWeak         __weak __typeof(self) weakSelf = self
@implementation NetRequest

/**
 *urlString：数据请求的接口
 *type：0为get请求，1为post请求
 *params：数据请求的参数
 *successBlock：数据请求成功
 *failBlock：数据请求失败
 */
+ (void)requestWithUrlString:(NSString *)urlString type:(NSInteger)type withParams:(NSDictionary *)params success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    // 当使用AF发送网络请求时,只要有网络操作,那么在状态栏(电池条)wifi符号旁边显示  菊花提示
    //    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [SVProgressHUD show];
    BAWeak;
    // 2.设置网络状态改变后的处理
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case -1: // 未知网络
                //                NSLog(@"未知网络");
                [MYFactoryManager showHint:@"未知网络，请检查您的网络！"];
                [SVProgressHUD dismiss];
                break;
            case 0: // 没有网络(断网)
                //                NSLog(@"没有网络");
                [MYFactoryManager showHint:@"当前没有网络，请检查您的网络！"];
                [SVProgressHUD dismiss];
                break;
            case 1: // 手机自带网络
                //                NSLog(@"手机自带网络");
            {
                [weakSelf requestWithString:urlString type:type withParams:params success:^(id data) {
                    successBlock(data);
                }fail:^(NSError *errorDes) {
                    failBlock(errorDes);
                }];
            }
                break;
            case 2: // WIFI
            {
                [weakSelf requestWithString:urlString type:type withParams:params success:^(id data) {
                    successBlock(data);
                }fail:^(NSError *errorDes) {
                     failBlock(errorDes);
                }];
            }
  
                break;
        }
    }];
    [manager startMonitoring];
}

+ (void)requestWithString:(NSString *)urlString type:(NSInteger)type withParams:(NSDictionary *)params success:(SuccessBlock)successBlock  fail:(FailBlock)failBlock{
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    if(type == 0){
        [manager1 GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"%@",downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self checkError:error fail:^(NSError *errorDes) {
                failBlock(error);
            }];
        }];
    }else{
        [manager1 POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"%@",uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self checkError:error fail:^(NSError *errorDes) {
                failBlock(error);
            }];
        }];
    }
}
+ (void)checkError:(NSError *)error  fail:(FailBlock)failBlock{
    
    [SVProgressHUD dismiss];
    
    if (error.code == NSURLErrorTimedOut) {
        
        [SVProgressHUD showInfoWithStatus:@"请求超时!"];
        return;
    }else if(error.code == NSURLErrorCannotConnectToHost) {
        
        [SVProgressHUD showInfoWithStatus:@"服务器连接异常，请稍后再试!"];
        return;
        
    }else if(error.code == -1011) {
        [SVProgressHUD showInfoWithStatus:@"身份已过期，请重新登录!"];
        
        for (id  key in error.userInfo) {
            if ([key isEqual:@"com.alamofire.serialization.response.error.data"]) {
                NSData *data1 = error.userInfo[key];
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableLeaves error:nil];
//                NSLog(@"%@===============%@",dic,dic[@"error"]);
                if ([dic[@"error"] isEqualToString:@"invalid_token"]) {
                    
                    double delayInSeconds = 3.0;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        AppDelegateInstance.window.rootViewController = [UIStoryboard storyboardWithName:@"Login" bundle:nil].instantiateInitialViewController;
                    });
//                    [self oauthToken];
                    return ;
                }else{
                    failBlock(error);
                }
            }
        }
        
        
        
    }else{
        failBlock(error);
    }
}

/**
 *urlString：数据请求的接口
 *params：数据请求的参数
 *key：文件名
 *image：上传的图片
 *successBlock：数据请求成功
 *failBlock：数据请求失败
 */
+ (void)postImageDataWithUrlString:(NSString *)urlString withParams:(NSDictionary *)params picDataKey:(NSString *)key image:(UIImage *)image success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    [SVProgressHUD show];
    //获取图片
    NSData *picData;
    NSString *picType;
    //判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(image)) {
        //返回为png图像。
        picType = @"png";
        picData = UIImagePNGRepresentation(image);
    }else {
        //返回为JPEG图像。
        picType = @"jpeg";
        picData = UIImageJPEGRepresentation(image, 1.0);
    }
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *afmanager = [AFNetworkReachabilityManager sharedManager];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"Basic ZmlybTp6dFYzZGJ0ZEN0TzA0YkV1SEt5NGdTTGt6b2ZOaWh2RQ==" forHTTPHeaderField:@"Authorization"];
    [SVProgressHUD show];
    // 2.设置网络状态改变后的处理
    [afmanager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case -1: // 未知网络
                //                NSLog(@"未知网络");
                [MYFactoryManager showHint:@"未知网络，请检查您的网络！"];
                [SVProgressHUD dismiss];
                break;
            case 0: // 没有网络(断网)
                //                NSLog(@"没有网络");
                [MYFactoryManager showHint:@"当前没有网络，请检查您的网络！"];
                [SVProgressHUD dismiss];
                break;
            case 1: // 手机自带网络
                //                NSLog(@"手机自带网络");
            {
                [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                    // 要解决此问题，
                    // 可以在上传时使用当前的系统事件作为文件名
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    // 设置时间格式
                    formatter.dateFormat = @"yyyyMMddHHmmss";
                    NSString *str = [formatter stringFromDate:[NSDate date]];
                    NSString *fileName = [NSString stringWithFormat:@"%@.%@",str,picType];
                    [formData appendPartWithFileData:picData name:key fileName:fileName mimeType:picType];
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    NSLog(@"%@",uploadProgress);
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [SVProgressHUD dismiss];
                    successBlock(responseObject);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [self checkError:error fail:^(NSError *errorDes) {
                        failBlock(error);
                    }];
                }];
            }
                break;
            case 2: // WIFI
            {
                [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                    // 要解决此问题，
                    // 可以在上传时使用当前的系统事件作为文件名
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    // 设置时间格式
                    formatter.dateFormat = @"yyyyMMddHHmmss";
                    NSString *str = [formatter stringFromDate:[NSDate date]];
                    NSString *fileName = [NSString stringWithFormat:@"%@.%@",str,picType];
                    [formData appendPartWithFileData:picData name:key fileName:fileName mimeType:picType];
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    NSLog(@"%@",uploadProgress);
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [SVProgressHUD dismiss];
                    successBlock(responseObject);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [self checkError:error fail:^(NSError *errorDes) {
                        failBlock(error);
                    }];
                }];
            }
                
                break;
        }
    }];
    [afmanager startMonitoring];
}

@end
