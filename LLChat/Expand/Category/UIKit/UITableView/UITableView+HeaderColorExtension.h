//
//  UITableView+HeaderColorExtension.h
//  yingfutong
//
//  Created by 张立清 on 2017/9/23.
//  Copyright © 2017年 jimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (HeaderColorExtension)

@property (nonatomic, strong, readonly) UIView *headerColorView;

// 添加头部颜色视图
- (void)addHeaderColorViewWithColor:(UIColor *)color;

// 在dealloc方法中调用
- (void)removeHeaderColorObserver;

@end
