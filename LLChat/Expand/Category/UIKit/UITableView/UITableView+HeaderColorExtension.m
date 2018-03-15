//
//  UITableView+HeaderColorExtension.m
//  yingfutong
//
//  Created by 张立清 on 2017/9/23.
//  Copyright © 2017年 jimi. All rights reserved.
//

#import "UITableView+HeaderColorExtension.h"
#import <objc/runtime.h>
#import "UIView+Positioning.h"

static NSString *const kColorViewKey = @"colorViewKey";
static NSString * kScrollContextKey = @"scroll_contenx";

@implementation UITableView (HeaderColorExtension)

- (void)setHeaderColorView:(UIView *)headerColorView
{
    [self willChangeValueForKey:@"headerColorView"];
    objc_setAssociatedObject(self, &kColorViewKey, headerColorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"headerColorView"];
}

- (UIView *)headerColorView
{
    return objc_getAssociatedObject(self, &kColorViewKey);
}

- (void)removeHeaderColorObserver
{
    [self removeObserver:self forKeyPath:@"contentOffset" context:(__bridge void *)kScrollContextKey];
}

- (void)addHeaderColorViewWithColor:(UIColor *)color
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.x, self.y, [UIScreen mainScreen].bounds.size.width, 0)];
    view.backgroundColor = color;
    [self setHeaderColorView:view];
   
    [self addObserver:self
           forKeyPath:@"contentOffset"
              options:NSKeyValueObservingOptionNew
              context:(__bridge void *)kScrollContextKey];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    BOOL isSameContext = NO;
    if (context) {
        id oc_context = (__bridge id)context;
        if ([oc_context isKindOfClass:[NSString class]] && [oc_context isEqualToString:kScrollContextKey]) {
            isSameContext = YES;
        }
    }
    
    if ([keyPath isEqualToString:@"contentOffset"] &&
        object == self && isSameContext) {
        [self modifyHeaderViewFrameWhenScrolling];
    } else {
        [super observeValueForKeyPath:keyPath  ofObject:object change:change context:context];
    }
}

- (void)modifyHeaderViewFrameWhenScrolling
{
    CGFloat offy = self.contentOffset.y;
    
    if (offy < 0) {
        self.headerColorView.frame = CGRectMake(self.headerColorView.x, self.headerColorView.y, self.headerColorView.bounds.size.width, -offy);
    } else {
        self.headerColorView.frame = CGRectMake(self.headerColorView.x, self.headerColorView.y, self.headerColorView.bounds.size.width, 0);
    }
}

@end
