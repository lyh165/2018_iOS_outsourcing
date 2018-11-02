//
//  MYFactoryManager.h
//  GoHiking_app
//
//  Created by qf on 15/10/13.
//  Copyright (c) 2015年 qf. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
//懒加载专用
typedef void(^CellBtnBlock)(UIButton *button);
@interface MYFactoryManager : NSObject

/**高度自适应*/
+ (CGFloat)heightForString:(NSString *)string fontSize:(CGFloat)fontSize andWidth:(CGFloat)width;

/**宽度自适应*/
+ (CGFloat)widthForString:(NSString *)string fontSize:(CGFloat)fontSize andHeight:(CGFloat)height;
//时间计算
+ (NSString *)getStartTimeDate:(NSString *)dateTime format:(NSString *)format;
+ (NSString *)getTime:(NSString *)dateTime;
+ (NSString *) returnUploadTime:(NSString *)timeStr;


+ (NSString *)returnTimestamp:(NSString *)timeStr;

//字符串转字典与字典转字符串
+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

//将号码转为省略号字符串
+ (NSString *)getPhoneText:(NSString *)text;
//缩小图片
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
//手机号的判断
+ (BOOL)phoneNum:(NSString *) textString;
//只能输入零和非零开头的数字：”^(0|[1-9][0-9]*)$”
+ (BOOL)inputNum:(NSString *) textString;

//分割线
+ (UIView *)splitLineWithColor:(UIColor *)color minY:(CGFloat)minY minX:(CGFloat)minX;

//可变字体
+ (NSAttributedString *)string:(NSString *)string appendAttString:(NSString *)attString attStyle:(NSDictionary *)attStyle;
//价格输入的判断，在- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string中调用
+ (BOOL)ConformToTheMoneyInputString:(NSString *)string shouldChangeCharactersInRange:(NSRange)range currtentTextField:(UITextField *)textField;


//判断内容是否为空
+ (NSString *)stingIsNil:(id)object string:(NSString *)string type:(NSInteger)type;
//显示菊花的效果
+ (void)showHudInViewhint:(NSString *)string;
//显示提示框
+ (void)showHint:(NSString *)string;
//隐藏菊花
+ (void)showHideview;
//判空，返回对应的值
+ (NSString *)returnRealValue:(id)sendValue ;
+ (NSString *)returnValue:(id)sendValue;
//计算缓存文件的大小
+(float)getCacheSize;
//清楚缓存文件
+(void)clearCache;
//将数组转为带双引号的字符串
+ (NSString *)getString:(NSArray *)arr;
// 根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL;
+ (void)countdownWith:(UIButton *)but;
+ (NSString *)getSha1String:(NSString *)srcString;
//返回正确的url
+ (NSURL *)returnUrl:(NSString *)url;
@end
