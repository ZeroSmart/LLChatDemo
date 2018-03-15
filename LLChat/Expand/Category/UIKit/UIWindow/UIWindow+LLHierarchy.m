//
//  UIWindow+LLHierarchy.m
//  YDTicketTong
//
//  Created by alex on 17/2/20.
//  Copyright © 2017年 alex. All rights reserved.
//

#import "UIWindow+LLHierarchy.h"

@implementation UIWindow (LLHierarchy)

+ (UIViewController *)currentVC {
    
    UIViewController *resultVC = nil;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *tmpWindow in windows) {
            
            if (tmpWindow.windowLevel == UIWindowLevelNormal) {
                window = tmpWindow;
                break;
            }
        }
    }
    
    UIView *fontView = window.subviews.firstObject;
    id nextResponder = [fontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        resultVC = nextResponder;
    }else {
        resultVC = window.rootViewController;
    }
    
    if ([resultVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabVC = (UITabBarController *)resultVC;
        UIViewController *selVC = tabVC.selectedViewController;
        resultVC = selVC;
    }
    
    return resultVC;
}



@end
