//
//  BaseNavigationController.h
//  TTNetworking
//
//  Created by alex on 17/4/28.
//  Copyright © 2017年 alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BaseNavigationController : UINavigationController

- (void)setNavigationBarTitleAttributes:(NSDictionary *)dictionary;

@property (nonatomic, strong, readwrite) UIColor *backgoundColor;

/// 返回按钮
@property (nonatomic, strong, readwrite) UIButton *backBarButton;

/// 返回按钮点击事件的回调，回调为nil的时候，默认pop 或者 dismiss，否则不处理
@property (nonatomic, copy) dispatch_block_t backButtonTappedBlock;

@end
