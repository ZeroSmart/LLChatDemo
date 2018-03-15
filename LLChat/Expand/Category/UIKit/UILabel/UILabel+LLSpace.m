//
//  UILabel+DDExtension.m
//  yingfutong
//
//  Created by 张立清 on 2017/12/5.
//  Copyright © 2017年 jimi. All rights reserved.
//

#import "UILabel+LLSpace.h"

@implementation UILabel (LLSpace)

- (void)setLabelSpace:(CGFloat)space withString:(NSString *)string withFont:(UIFont *)font
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = space; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{
                          NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:paraStyle,
                          NSKernAttributeName:@1.5f,
                          NSForegroundColorAttributeName : [UIColor blackColor]
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:string attributes:dic];
    self.attributedText = attributeStr;
}

+ (CGFloat)labelHeightWithString:(NSString *)string
                        withFont:(UIFont *)font
                       withWidth:(CGFloat)width
                       withSpace:(CGFloat)lineSpace
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpace;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:dic context:nil].size;
    return size.height;
}


@end
