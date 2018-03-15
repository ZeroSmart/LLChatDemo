//
//  NSObject+Swizzle.h
//  TestSafeCollection
//
//  Created by 席萍萍 on 2016/11/10.
//  Copyright © 2016年 Yundi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

+ (void)swizzleInstanceMethodOfClass:(Class)aClass originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
