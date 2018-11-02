//
//  UIImage+Compress.h
//  AppsTemplate
//
//  Created by Rayco on 13-1-8.
//  Copyright (c) 2013年 Apps123. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compress)
//压缩的图片
- (UIImage *)compressedImage;
//压缩图片的最大值
- (UIImage *)compressedImageByCtrl:(CGFloat)maxPix;
//根据压缩图片的质量进行压缩
- (NSData *)compressedData:(CGFloat)compressionQuality;
//图片的压缩质量
- (CGFloat)compressionQuality;

- (NSData *)compressedData;
//根据输入的大小裁剪图片
- (UIImage *)scaleToSize:(CGSize)size;

- (UIImage *)scaleImageByTargetWidth:(CGFloat)defineWidth;


@end
