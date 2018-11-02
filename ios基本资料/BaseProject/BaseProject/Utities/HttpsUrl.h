//
//  Constants.h
//  CarSpider
//
//  Created by fwios001 on 15/11/23.
//  Copyright © 2015年 fwios001. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define iPhone6                                                                \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(750, 1334),                              \
[[UIScreen mainScreen] currentMode].size)           \
: NO)
#define iPhone6Plus                                                            \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(1242, 2208),                             \
[[UIScreen mainScreen] currentMode].size)           \
: NO)

//极光配置
#define JPushAppKey @"9f26ad4e76c6d4073c6df153"
#define JPushChannel @"Publish channel"
//百度mapID
//#define BAIDUMAP_APIKEY @"bhUVGuS7tBbiteyV0sqVrTV3ofQE3HGw"//测试
#define BAIDUMAP_APIKEY @"3IqYOl7tZko3xfGgxQC95DzZB1kOcY7A"//发布

//融云基础设置4z3hlwrv3n0it
#define SERVICE_ID @"KEFU145940564474556"
#define RONGCLOUD_IM_APPKEY @"25wehl3uwm6kw"
#define RONGCLOUD_IM_USER_TOKEN @"VVqp3FPmHA21hOSK33JQIyVq4rXbDbbaPIcMvvrHBBwLlvHeeZH1pDhnWsuvaInlm7edYHJb0Oq6KMM9LQLdCs2CwrcER3ng9LFywRX1HiM="

#define BASE_URL @"http://192.168.1.77:8080/e_logistic/"//其他的基本URL
#define IMAGE_URL @"http://www.quannengdd.com:8080/"//图片的基本URL

#endif
