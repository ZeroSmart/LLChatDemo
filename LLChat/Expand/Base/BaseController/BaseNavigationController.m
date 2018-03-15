//
//  BaseNavigationController.m
//  TTNetworking
//
//  Created by alex on 17/4/28.
//  Copyright © 2017年 alex. All rights reserved.
//

#import "BaseNavigationController.h"
// tools
#import "UIImage+LLColor.h"
#import "UINavigationBar+Awesome.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setNavigationBarTitleAttributes:(NSDictionary *)dictionary
{
    if (!dictionary) return;
    [self.navigationBar setTitleTextAttributes:dictionary];
}

- (void)setBackgoundColor:(UIColor *)backgoundColor
{
    [self.navigationBar lt_setBackgroundColor:backgoundColor];
    
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = self.viewControllers.count > 0;
    [super pushViewController:viewController animated:animated];
    
    if (viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count > 1) {
        // 创建返回按钮
        if (!self.backBarButton) {
            return;
        }
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBarButton];
        // 如果自定义返回按钮后, 滑动返回可能失效, 需要添加下面的代码
        __weak typeof(viewController)Weakself = viewController;
        self.interactivePopGestureRecognizer.delegate = (id)Weakself;
    }
}

- (void)setBackBarButton:(UIButton *)backBarButton
{
    _backBarButton = backBarButton;
    [backBarButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    
    return self.topViewController;
}

#pragma mark - Touch Events

- (void)backButtonTapped:(UIButton *)button
{
    if (self.backButtonTappedBlock) {
        self.backButtonTappedBlock();
        return;
    }
    
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self popViewControllerAnimated:YES];
    }
}

@end
