//
//  UIImage+CompressImage.m
//  AJNetwork
//
//  Created by Hello on 2019/1/23.
//  Copyright © 2019 LSJ. All rights reserved.
//

#import "UIImage+CompressImage.h"

@implementation UIImage (CompressImage)
/**
 传入图片,需要的大小,比例,得到压缩图片大小
 
 @param image 需要压缩的图片
 @param size  压缩后图片的大小
 @param scale 压缩的比例 0.0 - 1.0
 @return 返回新的图片
 */
+ (JPEGImage *)needCompressImage:(UIImage *)image
                            size:(CGSize )size
                           scale:(CGFloat )scale
{
    return [self needToCompressImage:image size:size scale:scale];
}

+ (JPEGImage *)needCompressImageData:(NSData *)imageData
                                size:(CGSize )size
                               scale:(CGFloat )scale
{
    PNGImage *image = [UIImage imageWithData:imageData];
    return [UIImage needToCompressImage:image size:size scale:scale];
}

/**
 传入图片,获取中间部分,需要的大小,压缩比例
 
 @param image 需要压缩的图片
 @param size  压缩后图片的大小
 @param scale 压缩的比例 0.0 - 1.0
 @return 返回新的图片
 */
+ (JPEGImage *)needCenterImage:(UIImage *)image
                          size:(CGSize )size
                         scale:(CGFloat )scale
{
    /* 想切中间部分,待解决 */
    //#warning area of center image
    JPEGImage *newImage = nil;
    //创建画板
    UIGraphicsBeginImageContext(size);
    //写入图片,在中间
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //得到新的图片
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    //释放画板
    UIGraphicsEndImageContext();
    //比例压缩
    newImage = [UIImage imageWithData:UIImageJPEGRepresentation(newImage, scale)];
    
    return newImage;
}


/**
 png图片转为jpeg(jpg)图片
 
 @param pngImage 需要转为jpeg的png图片
 @return 返回一张jpeg图片
 */
+(JPEGImage *)jpegImageWithPNGImage:(PNGImage *)pngImage
{
    return [UIImage needToCompressImage:pngImage size:pngImage.size scale:1.0];
}

+(JPEGImage *)jpegImageWithPNGData:(PNGData *)pngData
{
    PNGImage *pngImage = [UIImage imageWithData:pngData];
    return [UIImage needToCompressImage:pngImage size:pngImage.size scale:1.0];
}

+(JPEGData *)jpegDataWithPNGData:(PNGData *)pngData
{
    return UIImageJPEGRepresentation([UIImage jpegImageWithPNGData:pngData], 1.0);
}

+(JPEGData *)jpegDataWithPNGImage:(PNGImage *)pngImage
{
    return UIImageJPEGRepresentation([UIImage jpegImageWithPNGImage:pngImage], 1.0);
}

+ (JPEGImage *)needToCompressImage:(UIImage *)image
                              size:(CGSize )size
                             scale:(CGFloat )scale
{
    JPEGImage *newImage = nil;
    //创建画板
    UIGraphicsBeginImageContext(size);
    //写入图片,在中间
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //得到新的图片
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    //释放画板
    UIGraphicsEndImageContext();
    //比例压缩
    newImage = [UIImage imageWithData:UIImageJPEGRepresentation(newImage, scale)];
    return newImage;
}


@end
