//
//  UITextField+TTLimit.m
//  LLDemo
//
//  Created by 张立清 on 2018/3/14.
//  Copyright © 2018年 com.yasetime. All rights reserved.
//

#import "UITextField+TTLimit.h"
#import <objc/runtime.h>

@implementation UITextField (TTLimit)

static char kLimitKey;

- (void)setLimitBlock:(LimitBlock)limitBlock
{
    objc_setAssociatedObject(self, &kLimitKey, limitBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LimitBlock)limitBlock
{
    return objc_getAssociatedObject(self, &kLimitKey);
}

- (void)lengthLimit:(void (^)(void))limit
{
    [self addTarget:self
             action:@selector(textFieldEditChanged:)
   forControlEvents:UIControlEventEditingChanged];
    self.limitBlock = limit;
}

- (void)textFieldEditChanged:(UITextField *)textField
{
    // 键盘输入模式
    NSString *primaryLanguage = [[UIApplication sharedApplication] textInputMode].primaryLanguage;
    if ([primaryLanguage isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textField markedTextRange];
       
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (self.limitBlock) {
                self.limitBlock();
            }
        }
    } else {
        if (self.limitBlock) {
            self.limitBlock();
        }
    }
}



@end
