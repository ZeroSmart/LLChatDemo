//
//  UITableViewCell+SeperateLine.m
//  yingfutong
//
//  Created by alex on 17/6/5.
//  Copyright © 2017年 jimi. All rights reserved.
//

#import "UITableViewCell+SeperateLine.h"
#import <objc/runtime.h>
#import "UIView+Positioning.h"

#define TAG_LINE_TOP     1
#define TAG_LINE_BOTTOM  2

static char kTopLineKey;
static char kBottomLineKey;
static char kLeftLineKey;
static char kRightLineKey;

#define KLINEHEIGHT  (1 / [UIScreen mainScreen].scale)
#define KLINECOLOR   ([UIColor colorWithRed:215 / 255.0f green:215 / 255.0f blue:215 / 255.0f alpha:1.0])

@implementation UITableViewCell (SeperateLine)

- (void)addTopLine:(BOOL)top bottomLine:(BOOL)bottom
{
    [self addTopLine:top topInSet:0.0 bottomLine:bottom bottomInset:0.0];
}

- (void)addLineAtTop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right
{
    [self addTopLine:top topInSet:0.0 bottomLine:bottom bottomInset:0.0];
    
    if (left) {
        [self bottomLine].left = 0;
        [self bottomLine].right = 0;
        [self bottomLine].bottom = 0;
        [self bottomLine].width = KLINEHEIGHT;
    }
    
    if (right) {

        self.rightLine.top = 0;
        self.rightLine.bottom = 0;
        self.rightLine.width = KLINEHEIGHT;
        self.rightLine.right = 0;
    }
}

- (void)addTopLine:(BOOL)top topInSet:(CGFloat)topInset bottomLine:(BOOL)bottom bottomInset:(CGFloat)bottomInset
{
    if (top) {
        [self topLine].left = 0;
        [self topLine].right = 0;
        [self topLine].top = 0;
        [self topLine].height = KLINEHEIGHT;
    }
    
    if (bottom) {
        
        [self bottomLine].left = 0;
        [self bottomLine].right = 0;
        [self bottomLine].bottom = 0;
        [self bottomLine].height = KLINEHEIGHT;
    }
}

#pragma mark - Setter && Getter

- (void)setTopLine:(UIView *)topLine
{
    objc_setAssociatedObject(self, &kTopLineKey, topLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBottomLine:(UIView *)bottomLine
{
    objc_setAssociatedObject(self, &kBottomLineKey, bottomLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)rightLine
{
    UIView *line = objc_getAssociatedObject(self, &kRightLineKey);
    if (!line) {
        line = [self setupLine];
        [self addSubview:line];
        objc_setAssociatedObject(self, &kRightLineKey, line, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return line;
}

- (UIView *)leftLine
{
    UIView *line = objc_getAssociatedObject(self, &kLeftLineKey);
    if (!line) {
        line = [self setupLine];
        [self addSubview:line];
        objc_setAssociatedObject(self, &kLeftLineKey, line, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return line;
}

- (UIView *)topLine
{
    UIView *top = objc_getAssociatedObject(self, &kTopLineKey);
    if (!top) {
        top = [self setupLine];
        [self addSubview:top];
        [self setTopLine:top];
    }
    return top;
}

- (UIView *)bottomLine
{
    UIView *line = objc_getAssociatedObject(self, &kBottomLineKey);
    if (!line) {
        line = [self setupLine];
        [self addSubview:line];
        [self setBottomLine:line];
    }
    return line;
}

- (UIView *)setupLine
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = KLINECOLOR;
    return view;
}



@end
