

#import "NSString+LLSize.h"

@implementation NSString (LLSize)
/**
 计算文字的高度
 
 @param fontSize 系统字体大小
 @param width 约束宽度
 @return 计算得到的高度
 */
- (CGFloat)ll_heightWithSystemFontSize:(CGFloat )fontSize constrainedToWidth:(CGFloat)width{
    return [self ll_sizeWithFont:[UIFont systemFontOfSize:fontSize] constainedSize:CGSizeMake(width, CGFLOAT_MAX)].height;
}
/**
 计算文字的高度
 
 @param font 字体
 @param height 约束宽度
 @return 计算得到的高度
 */
- (CGFloat)ll_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    return [self ll_sizeWithFont:font constainedSize:CGSizeMake(width, CGFLOAT_MAX)].height;
}
/**
 计算文字的宽度
 
 @param font 字体
 @param height 约束高度
 @return 计算得到的宽度
 */
- (CGFloat)ll_widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height
{
    return [self ll_sizeWithFont:font constainedSize:CGSizeMake(CGFLOAT_MAX, height)].width;
}
/**
 计算文字的大小
 
 @param font 字体
 @param height 约束宽度
 @return 计算得到的大小
 */
- (CGSize)ll_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    return [self ll_sizeWithFont:font constainedSize:CGSizeMake(width, CGFLOAT_MAX)];
}
/**
 计算文字的大小
 
 @param font 字体
 @param height 约束高度
 @return 计算得到的大小
 */
- (CGSize)ll_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height
{
    return [self ll_sizeWithFont:font constainedSize:CGSizeMake(CGFLOAT_MAX, height)];
}
/**
 计算文字的大小
 
 @param font 字体
 @param size 文字宽高限制大小
 @return 计算得到的大小
 */
- (CGSize)ll_sizeWithFont:(UIFont *)font constainedSize:(CGSize)size{
    NSDictionary *dic = @{NSFontAttributeName : font};
    CGSize textSize = [self boundingRectWithSize:size
                                         options:(NSStringDrawingUsesLineFragmentOrigin |
                                                  NSStringDrawingTruncatesLastVisibleLine)
                                      attributes:dic context:nil].size;
    return textSize;
}

@end
