//
//  UITextField+TTLimit.h
//  LLDemo
//
//  Created by 张立清 on 2018/3/14.
//  Copyright © 2018年 com.yasetime. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LimitBlock)(void);

/**
 调用方法
 [self.textField lengthLimit:^{
 if (self.textField.text.length > 5) {
 self.textField.text = [self.textField.text substringToIndex:5];
 }
 }];
 */

@interface UITextField (TTLimit)

@property (nonatomic, copy) LimitBlock limitBlock;

- (void)lengthLimit:(void (^)(void))limit;

@end
