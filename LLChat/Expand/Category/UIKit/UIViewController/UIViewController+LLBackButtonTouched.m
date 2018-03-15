//
//  UIViewController+LLBackButtonTouched.m
//  Categories
//
//  Created by zhouXian on 2017/8/16.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "UIViewController+LLBackButtonTouched.h"
#import <objc/runtime.h>
static const void *LLBackButtonHandlerKey = &LLBackButtonHandlerKey;

@implementation UIViewController (LLBackButtonTouched)
-(void)ll_backButtonTouched:(LLBackButtonHandler)backButtonHandler{
    objc_setAssociatedObject(self, LLBackButtonHandlerKey, backButtonHandler, OBJC_ASSOCIATION_COPY);
}
- (LLBackButtonHandler)ll_backButtonTouched
{
    return objc_getAssociatedObject(self, LLBackButtonHandlerKey);
}
@end
@implementation UINavigationController (ShouldPopItem)
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
   	UIViewController* vc = [self topViewController];
    LLBackButtonHandler handler = [vc ll_backButtonTouched];
    if (handler) {
        // Workaround for iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments/34452906
        
        for(UIView *subview in [navigationBar subviews]) {
            if(subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(self);
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    }
    
    return NO;
}
@end
