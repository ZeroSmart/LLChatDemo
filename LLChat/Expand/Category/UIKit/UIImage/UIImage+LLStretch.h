

#import <UIKit/UIKit.h>

@interface UIImage (LLStretch)
/**
 *  拉伸图片，四个角不变形
 *
 *  @param imageName 图片名称
 *  @return 拉伸过的图片
 */
+ (UIImage *)ll_stretchImage:(NSString *)imageName;

/**
 *  拉伸图片，四个角不变形
 *
 *  @param imgName 图片名称
 *  @param xPos    左右不拉伸的比例 0 ~ 0.5
 *  @param yPos    上下不拉伸的比例 0 ~ 0.5
 *  @return 拉伸过的图片
 */
+ (UIImage *)ll_stretchImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;

/**
 *  拉伸图片，四个角不变形
 *
 *  @param imgName 图片名称
 *  @param insets  拉伸四周的高度
 *  @return 拉伸过的图片
 */
+ (UIImage *)ll_stretchImage:(NSString *)imgName insets:(UIEdgeInsets)insets;
@end
