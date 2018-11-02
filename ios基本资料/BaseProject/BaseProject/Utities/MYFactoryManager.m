//
//  MYFactoryManager.m
//  GoHiking_app
//
//  Created by qf on 15/10/13.
//  Copyright (c) 2015年 qf. All rights reserved.
//

#import "MYFactoryManager.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MYFactoryManager


//手机输入
+ (BOOL)phoneNum:(NSString *) textString {
    if (textString.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,155,156,170,171,172,175,176,185,186
     * 电信号段: 133,149,153,170,173,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,170,171,172,175,176,185,186
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|701256||8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:textString] == YES)
        || ([regextestcm evaluateWithObject:textString] == YES)
        || ([regextestct evaluateWithObject:textString] == YES)
        || ([regextestcu evaluateWithObject:textString] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


#pragma mark -- 计算高度
+ (CGFloat)heightForString:(NSString *)string fontSize:(CGFloat)fontSize andWidth:(CGFloat)width{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size.height;
}

+ (CGFloat)widthForString:(NSString *)string fontSize:(CGFloat)fontSize andHeight:(CGFloat)height{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    
    return rect.size.width;
}

#pragma mark -- 时间
+ (NSString *)getStartTimeDate:(NSString *)dateTime format:(NSString *)format{
    if (format == nil) {
        format = @"yyyy/MM/dd";
    }
    if ([dateTime isKindOfClass:[NSNull class]] || dateTime.length < 3) {
        return @"";
    }
    dateTime = [dateTime substringToIndex:dateTime.length-3];
    NSTimeInterval time= [dateTime doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式 @"yyyy/MM/dd"
    [dateFormatter setDateFormat:format];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}
+ (NSString *)getTime:(NSString *)dateTime{
    if (dateTime.length > 0) {
        NSArray *arr = [dateTime componentsSeparatedByString:@" "];
        return arr[0];
    }else{
        return @"";
    }
}
/**
 返回时间戳
 */
+ (NSString *)returnTimestamp:(NSString *)timeStr{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //设定时间格式，这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:timeStr];
    NSTimeInterval timeSp = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%f",timeSp];
}


/*处理返回应该显示的时间*/
+ (NSString *) returnUploadTime:(NSString *)timeStr
{
    NSTimeInterval time= [timeStr doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    NSDate *datenow = [NSDate date];
    NSDateFormatter * dm = [[NSDateFormatter alloc]init];
    //指定输出的格式   这里格式必须是和上面定义字符串的格式相同，否则输出空
    [dm setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate * newdate = [dm dateFromString:currentDateStr];
    long dd = (long)[datenow timeIntervalSince1970] - [newdate timeIntervalSince1970];
    NSString *timeString=@"";
    if (dd/3600<1)
    {
        timeString = [NSString stringWithFormat:@"%ld", dd/60];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    if (dd/3600>1&&dd/86400<1)
    {
        timeString = [NSString stringWithFormat:@"%ld", dd/3600];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (dd/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%ld", dd/86400];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    return timeString;
}

//字符串转字典与字典转字符串
+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    return responseJSON;
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)getPhoneText:(NSString *)text{
    NSString *star = [text substringToIndex:3];
    NSString *end = [text substringFromIndex:text.length-3];
    NSString *phone = [star stringByAppendingString:[NSString stringWithFormat:@"*****%@",end]];
    return phone;
    
}
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    if (image.size.width > 550 || image.size.height > 550) {
        UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
        [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
//        NSLog(@"%@",NSStringFromCGSize(scaledImage.size));
        return scaledImage;
    }
    else{
        return image;
    }
}
//只能输入零和非零开头的数字：”^(0|[1-9][0-9]*)$”
+ (BOOL)inputNum:(NSString *) textString{
    NSString *number = @"^[1-9][0-9]|[1-9]+(\\.[0-9]{1,3})?|[0]+(\\.[0-9]{1,3})?$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}
//分割线
+ (UIView *)splitLineWithColor:(UIColor *)color minY:(CGFloat)minY minX:(CGFloat)minX{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(minX, minY, screen_width - minX, 0.5)];
    view.backgroundColor = color;
    return view;
}

//lable字体显示
+ (NSAttributedString *)string:(NSString *)string appendAttString:(NSString *)attString attStyle:(NSDictionary *)attStyle{
    NSMutableAttributedString *attsString = [[NSMutableAttributedString alloc]initWithString:string] ;
    [attsString appendAttributedString:[[NSAttributedString alloc]initWithString:attString attributes:attStyle]];
    return attsString;
}


+ (BOOL)ConformToTheMoneyInputString:(NSString *)string shouldChangeCharactersInRange:(NSRange)range currtentTextField:(UITextField *)textField{
    BOOL isHavePoint = NO;
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHavePoint = NO;
    }else{
        isHavePoint = YES;
    }
    if ([string length] > 0) {
        if ([string length] != 1) {
            return NO;
        }
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            //首字母不能为0和小数点
            if([textField.text length] == 0){
                if(single == '.') {
                    return NO;
                }
                if (single == '0') {
                    return YES;
                }
            }
            
            //输入的字符串首字母是否为0
            if ([textField.text hasPrefix:@"0"]) {
                if (single == '.') {
                    if(!isHavePoint)//text中还没有小数点
                    {
                        isHavePoint = YES;
                        return YES;
                        
                    }else{
                        return NO;
                    }
                }else if (single == '0'){
                    if (isHavePoint) {
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 6) {
                            return YES;
                        }else{
                            return NO;
                        }
                    }
                    return NO;
                }else{
                    if (isHavePoint) {
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 6) {
                            return YES;
                        }else{
                            return NO;
                        }
                    }
                    return NO;
                }
            }
            
            //输入的字符是否是小数点
            if (single == '.') {
                if(!isHavePoint)//text中还没有小数点
                {
                    isHavePoint = YES;
                    return YES;
                    
                }else{
                    return NO;
                }
            }else{
                if (isHavePoint) {//存在小数点
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= 6) {
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            return NO;
        }
    }
    return YES;

}

//判断内容是否为空
+ (NSString *)stingIsNil:(id)object string:(NSString *)string type:(NSInteger)type
{
    NSString *str = @"";
    if ([object isKindOfClass:[NSNull class]]) {
        str = string;
    }else if (object == nil){
        str = string;
    }else if ([object isKindOfClass:[NSNumber class]]){
        if (type == 0) {
            str = [NSString stringWithFormat:@"%@%@",string,[object stringValue]];
        }else{
            str = [NSString stringWithFormat:@"%@%@",[object stringValue],string];
        }
        
    }else{
        if (type == 0) {
            str = [NSString stringWithFormat:@"%@%@",string,object];
        }else{
            str = [NSString stringWithFormat:@"%@%@",object,string];
        }
        
    }
    return str;
}
+ (void)showHudInViewhint:(NSString *)string{
    
}

+ (void)showHint:(NSString *)string{
    
    
}
+ (void)showHideview{
    
}

+ (NSString *)returnRealValue:(id)sendValue {
    if ([sendValue isKindOfClass:[NSNull class]] || sendValue == NULL) {
        return @"";
    }
    if ([sendValue isKindOfClass:[NSNumber class]]) {
        return [sendValue stringValue];
    }
    return sendValue;
}
+ (NSString *)returnValue:(id)sendValue {
    if ([sendValue isKindOfClass:[NSNull class]] || sendValue == NULL) {
        return @"0";
    }
    if ([sendValue isKindOfClass:[NSNumber class]]) {
        return [sendValue stringValue];
    }
    return sendValue;
}
+ (float)getCacheSize{
    // 获取Caches目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:cachesDir]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:cachesDir] objectEnumerator];//从前向后枚举器
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [cachesDir stringByAppendingPathComponent:fileName];
        CGFloat size = 0;
        NSFileManager* manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:fileAbsolutePath]){
            size = [[manager attributesOfItemAtPath:fileAbsolutePath error:nil] fileSize];
        }
        folderSize += size;
    }
    return folderSize/(1024.0*1024.0);
}
+ (void)clearCache{
    // 获取Caches目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    //清除缓存
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:cachesDir]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:cachesDir];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[cachesDir stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}
+ (NSString *)getString:(NSArray *)arr{
    NSMutableString *jsonString = [[NSMutableString alloc] initWithString:@"["];
    NSString *string2 = nil;
    
    if (arr.count > 0) {
        
        for (int i=0; i<arr.count; i++) {
            string2 = [NSString stringWithFormat:
                       @"\"%@\",",arr[i]];
            [jsonString appendString:string2];
        }
    }else {
        [jsonString appendString:@","];
    }
    // 3. 获取末尾逗号所在位置
    NSUInteger location = [jsonString length]-1;
    NSRange range       = NSMakeRange(location, 1);
    
    // 4. 将末尾逗号换成结束的]}
    [jsonString replaceCharactersInRange:range withString:@"]"];

    
    return jsonString;
}
// 根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}
//  获取PNG图片的大小
+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取gif图片的大小
+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}
+ (void)countdownWith:(UIButton *)but{
    
    __block int timeout=59; //倒计时时间
    UIColor *color = but.titleLabel.textColor;
    [but setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [but setTitle:@"发送验证码" forState:UIControlStateNormal];
                [but setTitleColor:color forState:(UIControlStateNormal)];
                but.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //                NSLog(@"____%@",strTime);
                [but setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                but.userInteractionEnabled = NO;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}
//sha1加密方式
+ (NSString *)getSha1String:(NSString *)srcString{
    
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}
//返回正确的url
+ (NSURL *)returnUrl:(NSString *)url{
    NSString *text = @"";
    if (![url isKindOfClass:[NSNull class]]) {
        if ([url containsString:@"\\"]) {
            url = [url stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
        }
        if ([url hasPrefix:@"http"]) {
            text = url;
        }else{
            text = [NSString stringWithFormat:@"%@%@",IMAGE_URL,url];
        }
    }
    return [NSURL URLWithString:text];
}
@end
