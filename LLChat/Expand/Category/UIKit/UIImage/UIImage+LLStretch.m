//
//  UIImage+LLStretch.m
//  LLCategories
//
//  Created by zhouXian on 2017/7/25.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "UIImage+LLStretch.h"

@implementation UIImage (LLStretch)
+ (UIImage *)ll_stretchImage:(NSString *)imageName
{
    return [self ll_stretchImage:imageName xPos:0.5 yPos:0.5];
}

+ (UIImage *)ll_stretchImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage * image = [UIImage imageNamed:imgName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}

+ (UIImage *)ll_stretchImage:(NSString *)imgName insets:(UIEdgeInsets)insets
{
    UIImage * image = [UIImage imageNamed:imgName];
    return [image resizableImageWithCapInsets:insets];
}
@end
