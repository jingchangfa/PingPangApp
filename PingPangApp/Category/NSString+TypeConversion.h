//
//  NSString+TypeConversion.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/12.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (TypeConversion)
/**
 * 字符串转化
 * toAttributedStringAndNormalColor 转化为 富文本
 * toStringSizeAndFountSize 转化为字符串的尺寸
 * toFileURL 本地路径转url
 * toURL 链接转url
 */
- (NSMutableAttributedString *)toAttributedStringAndNormalColor:(UIColor *)nolmalColor
                                               AndSeletedString:(NSArray<NSString *> *)selectedStringArray
                                               AndSelectenColor:(UIColor *)selColor;


- (CGSize)toStringSizeAndFountSize:(float)fountSize
                     AndFountWidth:(float)fountWidth
                        AndMaxSize:(CGSize)maxSize;//获取字符串的尺寸

- (NSURL *)toFileURL;
- (NSURL *)toURL;

@end
