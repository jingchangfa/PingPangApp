//
//  UIImage+ImageProcessing.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/12.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageProcessing)
/**
 图片的处理
 * fixOrientation 拍照的图片直接裁剪处理旋转90度的解决
 * cropThePictureToFitTheScreen 裁剪图片以适应屏幕(默认的裁剪)
 * compressImageToUniformSize 绘制图片到指定大小(统一尺寸)
 * compressThePictureToUpload 压缩图片以上传
 * getImageArrayFromPHAssetArray 通过 PHAsset 生成图片
 * boxblurImage 毛玻璃
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;
+ (UIImage *)compressImageToUniformSize:(UIImage *)aImage;
- (UIImage *)cropThePictureToFitTheScreen;
- (NSData *)compressThePictureToUpload;
+ (void)getImageArrayFromPHAssetArray:(NSArray *)assetArray AndFinishBlock:(void(^)(NSArray <UIImage *>*imageArray))block;
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;
@end
