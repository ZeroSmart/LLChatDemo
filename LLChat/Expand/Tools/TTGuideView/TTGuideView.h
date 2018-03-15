//
//  TTGuideView.h
//  Example
//
//  Created by alex on 17/3/31.
//  Copyright © 2017年 com.ayundi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTGuideView : UIView

/**
 在appDelegate中调用该方法
 @param imageNames 图片名称数组
 */

+ (instancetype)showGuideViewWithImageArray:(NSArray <NSString *> *)imageNames;

/**
    隐藏pageControl，默认不隐藏
 */
@property (nonatomic, assign) BOOL pageControlHidden;

/**
   默认灰色 [UIColor grayColor]
 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

/**
   默认白色 [UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

/**
    离底部距离
 */
@property (nonatomic, assign) CGFloat offsetY;

@end


@interface TTGuideCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *ttImageView;
@end
