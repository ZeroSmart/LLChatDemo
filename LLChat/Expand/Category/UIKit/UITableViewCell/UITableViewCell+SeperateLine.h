//
//  UITableViewCell+SeperateLine.h
//  yingfutong
//
//  Created by alex on 17/6/5.
//  Copyright © 2017年 jimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (SeperateLine)

- (void)addTopLine:(BOOL)top bottomLine:(BOOL)bottom;

- (void)addLineAtTop:(BOOL)top
                left:(BOOL)left
              bottom:(BOOL)bottom
               right:(BOOL)right;


- (void)addTopLine:(BOOL)top
          topInSet:(CGFloat)topInset
        bottomLine:(BOOL)bottom
       bottomInset:(CGFloat)bottomInset;

@property (nonatomic, strong, readonly) UIView *topLine;
@property (nonatomic, strong, readonly) UIView *bottomLine;
@property (nonatomic, strong, readonly) UIView *leftLine;
@property (nonatomic, strong, readonly) UIView *rightLine;

@end
