//
//  UIButton+LLImagePosition.h
//  yingfutong
//
//  Created by alex on 17/5/18.
//  Copyright © 2017年 jimi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LLImagePosition) {
    LLImagePositionLeft = 0,
    LLImagePositionRight = 1,
    LLImagePositionTop = 2,
    LLImagePositionBottom = 3,
};

@interface UIButton (LLImagePosition)


/**
 利用UIButton的titleEdgeInsets 和 imageEdgeInsets 来实现文字和图片的自由排列
 注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 @param spacing 图片和文字的间距
 */
- (void)setImagePostion:(LLImagePosition)position spacing:(CGFloat)spacing;

@end
