//
//  NSString+TypeConversion.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/12.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "NSString+TypeConversion.h"

@implementation NSString (TypeConversion)
- (NSMutableAttributedString *)toAttributedStringAndNormalColor:(UIColor *)nolmalColor
                                               AndSeletedString:(NSArray<NSString *> *)selectedStringArray
                                               AndSelectenColor:(UIColor *)selColor{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self];
    [attributeString setAttributes:@{NSForegroundColorAttributeName :nolmalColor
                                     }
                             range:NSMakeRange(0, self.length)];
    for (NSString *selectedString in selectedStringArray) {
        NSRange selRange = [self rangeOfString:selectedString];
        if (selRange.location != NSNotFound) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName :selColor
                                             }
                                     range: selRange];
        }
    }
    return attributeString;
}

- (CGSize)toStringSizeAndFountSize:(float)fountSize
                     AndFountWidth:(float)fountWidth
                        AndMaxSize:(CGSize)maxSize{
    UIFont *fount = [UIFont systemFontOfSize:fountSize weight:fountWidth];
    if (fountWidth == -1) {
        fount = [UIFont systemFontOfSize:fountSize];
    }
    NSDictionary *dic = @{NSFontAttributeName:fount};//输入的字体的大小
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    //    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
    CGSize stringSize = [self boundingRectWithSize:maxSize options:options attributes:dic context:nil].size;
    return stringSize;
}//获取字符串的尺寸

//- (NSTimeInterval)toTimeInterValWithFormatString:(NSString *)formatString{
//    if (!formatString) {
//        formatString = @"MM/dd HH:mm";
//    }
//    NSDateFormatter *dateformat = [[NSDateFormatter alloc]init];
//    [dateformat setDateFormat:formatString];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self longValue]/1000];
//    NSString *string = [dateformat stringFromDate:date];
//    return string;
//}

- (NSURL *)toFileURL{
    NSURL *url = [NSURL fileURLWithPath:self];
    return url;
}
- (NSURL *)toURL{
    NSURL *url = [NSURL URLWithString:self];
    return url;
}
@end
