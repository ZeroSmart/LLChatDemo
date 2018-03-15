//
//  UIViewController+LLBackButtonTouched.h
//  Categories
//
//  Created by zhouXian on 2017/8/16.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LLBackButtonHandler)(UIViewController *vc);

@interface UIViewController (LLBackButtonTouched)

/**
 返回按钮回调

 @param backButtonHandler backButtonHandler
 */
-(void)ll_backButtonTouched:(LLBackButtonHandler)backButtonHandler;
@end
