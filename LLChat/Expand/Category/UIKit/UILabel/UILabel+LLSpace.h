//
//  UILabel+DDExtension.h
//  yingfutong
//
//  Created by 张立清 on 2017/12/5.
//  Copyright © 2017年 jimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LLSpace)

- (void)setLabelSpace:(CGFloat)space
           withString:(NSString *)string
             withFont:(UIFont *)font;


+ (CGFloat)labelHeightWithString:(NSString *)string
                        withFont:(UIFont *)font
                       withWidth:(CGFloat)width
                       withSpace:(CGFloat)lineSpace;

@end
