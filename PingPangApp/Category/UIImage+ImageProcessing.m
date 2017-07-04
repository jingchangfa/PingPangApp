//
//  UIImage+ImageProcessing.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/12.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "UIImage+ImageProcessing.h"
#import <Photos/Photos.h>
#import <Accelerate/Accelerate.h>
@implementation UIImage (ImageProcessing)
#pragma mark 图片压缩
- (UIImage *)cropThePictureToFitTheScreen{
    CGSize screenSize = CGSizeMake(375, 667);
    CGFloat screenAspectRatio = screenSize.width/screenSize.height;
    //旋转
    UIImage *finalyImage = [UIImage fixOrientation:self];
    //裁剪 固定范围
    finalyImage = [self imageCutWithImage:finalyImage WithScreenAspectRatio:screenAspectRatio];
    //统一大小
    finalyImage = [UIImage compressImageToUniformSize:finalyImage];
    return finalyImage;
}
//1920*1080
+ (UIImage *)compressImageToUniformSize:(UIImage *)aImage{
    CGSize screenSize = CGSizeMake(375, 667);
    CGFloat screenAspectRatio = screenSize.width/screenSize.height;
    return [aImage compressImageWithHeight:1920 AndAspectRatio:screenAspectRatio];
}


- (UIImage *)imageCutWithImage:(UIImage *)fixImage WithScreenAspectRatio:(float)screenAspectRatio{
    CGSize imageSize = self.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    CGFloat imageAspectRatio = imageWidth/imageHeight;
    CGImageRef sourceImageRef = fixImage.CGImage;
    CGRect cutRect;
    if (imageAspectRatio>screenAspectRatio) {//高保留  裁宽(留中间)
        float width = imageHeight*screenAspectRatio;
        float orx = (imageSize.width-width)/2;
        cutRect = CGRectMake(orx, 0, width, imageSize.height);
    }else{//宽保留  裁高(留中间)
        float height = imageWidth*(1/screenAspectRatio);
        float ory = (imageSize.height-height)/2;
        cutRect = CGRectMake(0, ory, imageSize.width, height);
    }
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, cutRect);
    UIImage *image = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return image;
}
- (UIImage *)compressImageWithHeight:(CGFloat)height AndAspectRatio:(CGFloat)aspectRatio{
    float width = height*aspectRatio;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/**
 * 拍照的图片直接裁剪处理旋转90度的解决
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
//改变大小
- (NSData *)compressThePictureToUpload{
    return UIImageJPEGRepresentation(self,0.4);
}

//通过 PHAsset 生成图片
+ (void)getImageArrayFromPHAssetArray:(NSArray *)assetArray AndFinishBlock:(void(^)(NSArray <UIImage *>*imageArray))block{
    NSMutableArray<UIImage *> *imagesArray = [NSMutableArray array];
    for (PHAsset *asset in assetArray) {
        [self getImageFrm:asset AndFinishBlock:^(UIImage *image) {
            [imagesArray addObject:image];
            //            //图片统一下
            //            UIImage *newImage = [image cropThePictureToFitTheScreen];
        }];
    }
    if (block) {
        block(imagesArray);
    }
}
+ (void)getImageFrm:(PHAsset *)asset AndFinishBlock:(void(^)(UIImage *image))block{
    __block NSData *data;
    //    PHAssetResource *resource = [[PHAssetResource assetResourcesForAsset:asset] firstObject];
    //    resource.originalFilename; //
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.synchronous = YES;
    [[PHImageManager defaultManager] requestImageDataForAsset:asset
                                                      options:options
                                                resultHandler:
     ^(NSData *imageData,
       NSString *dataUTI,
       UIImageOrientation orientation,
       NSDictionary *info) {
         data = [NSData dataWithData:imageData];
     }];
    if(block){
        if (data.length>0) {
            block([UIImage imageWithData:data]);
        }
    }
}
#pragma mark 图片毛玻璃
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    //    return [self blureImage:image withInputRadius:5];
    return [self boxblurImage1:image withBlurNumber:blur];
}
+(UIImage *)boxblurImage1:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up  CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}

+ (UIImage *)blureImage:(UIImage *)originImage withInputRadius:(CGFloat)inputRadius
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage  *inputImage=[CIImage imageWithCGImage:originImage.CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(inputRadius) forKey: @"inputRadius"];
    
    //    CIFilter *filter1 = [CIFilter filterWithName:@"CIGaussianBlur"];
    //    [filter1 setValue:inputImage forKey:kCIInputImageKey];
    //    [filter1 setValue:@(3) forKey: @"inputRadius"];
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    //    CIImage *result1=[filter1 valueForKey:kCIOutputImageKey];
    //    CGRect extent = CGRectInset(result.extent, 10, 10);
    CGImageRef outImage=[context createCGImage:result fromRect:[inputImage extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    
    return blurImage;
}

//+ (UIImage *)drawWithCodeArray:(NSArray *)codeArray
//{
//    if(!codeArray) return nil;
//    CGRect rect = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, Bank_White_ffffff.CGColor);
//    CGContextFillRect(context, rect);//白色背景
//    //邀请码: 字
//    NSString *inviteString = KapLocalizedString(@"邀请码");
//    CGRect inviteRect = CGRectMake(20, 10, 100, 50);
//    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold"size:30.0f];
//    UIFont *codeFont = [UIFont fontWithName:@"HelveticaNeue-Bold"size:10.0f];
//    [inviteString drawInRect:inviteRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:Bank_Blue_2f95fb}];
//    NSDictionary *charStringAtt = @{NSFontAttributeName:codeFont,NSForegroundColorAttributeName:[UIColor blackColor]};
//    //先画行 在画列
//    float zOry = NEXT_VIEW_ORY_BY_FRAME(inviteRect);
//    float zOrx = 70;//左右开头位置
//    float lineWidth = (rect.size.width - zOrx*2);//格子+间隔线的总宽
//    float hLineSize = 5;//水瓶间隔
//    float vLineSize = 20;//竖直间隔
//    float rowSize = (lineWidth-hLineSize*5)/6;
//    for (int i = 0; i<codeArray.count; i++) {
//        NSString *oneCode = codeArray[i];
//        float lineOry = zOry + i*(rowSize+vLineSize);
//        for (int j = 0; j < oneCode.length; j++) {
//            NSString *charString = [NSString stringWithFormat:@"%c",[oneCode characterAtIndex:j]];
//            float rowOrx = zOrx + j*(rowSize+hLineSize);
//            //灰色格子
//            CGContextSetFillColorWithColor(context, BANK_GRAY_e5e5e5.CGColor);
//            CGContextFillRect(context,CGRectMake(rowOrx, lineOry, rowSize, rowSize));
//            CGSize charStringSize = [charString sizeWithAttributes:charStringAtt];
//            //写字(居中显示)
//            [charString drawAtPoint:CGPointMake(rowOrx+(rowSize-charStringSize.width)/2, lineOry+(rowSize-charStringSize.height)/2) withAttributes:charStringAtt];
//        }
//    }
//    //生成图片
//    CGImageRef imgRef = CGBitmapContextCreateImage(context);
//    UIImage *image = [UIImage imageWithCGImage:imgRef];
//    CGImageRelease(imgRef);
//    CGContextRelease(context);
//    return image;
//}
@end
