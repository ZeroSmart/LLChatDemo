//
//  NSDictionary+Safe.m
//  TestSafeCollection
//
//  Created by 席萍萍 on 2016/11/10.
//  Copyright © 2016年 Yundi. All rights reserved.
//

#import "NSDictionary+Safe.h"

#import <objc/runtime.h>
#import <objc/message.h>

#import "NSObject+Swizzle.h"

#define CurrentClass objc_getClass("__NSArrayI")


@implementation NSDictionary (Safe)

+ (void)load {
    [self swizzleInstanceMethodOfClass:NSClassFromString(@"__NSPlaceholderDictionary")
                      originalSelector:@selector(initWithObjects:forKeys:count:)
                      swizzledSelector:@selector(safe_initWithObjects:forKeys:count:)];
}


- (instancetype)safe_initWithObjects:(const id _Nonnull __unsafe_unretained *)objects forKeys:(const id _Nonnull __unsafe_unretained *)keys count:(NSUInteger)count
{
    BOOL hasNil = NO;
    for (NSUInteger i = 0; i < count; ++i) {
        if (!objects[i] || !keys[i]) {
            hasNil = YES;
            break;
        }
    }
    
    if (hasNil) {
        id __unsafe_unretained newObjects[count];
        id __unsafe_unretained newKeys[count];
        int j = 0;
        for (NSUInteger i = 0; i < count; ++i) {
            if (objects[i] && keys[i]) {
                newObjects[j] = objects[i];
                newKeys[j] = keys[i];
                j++;
            }
        }
        
        if (j==0) {
            return nil;
        }
        
        return [self safe_initWithObjects:newObjects forKeys:newKeys count:j];
    }
    
    return [self safe_initWithObjects:objects forKeys:keys count:count];
}

@end

@interface NSMutableDictionary (Safe)

@end

@implementation NSMutableDictionary (Safe)

+ (void)load {
    [self swizzleInstanceMethodOfClass:NSClassFromString(@"__NSDictionaryM")
                      originalSelector:@selector(setObject:forKey:)
                      swizzledSelector:@selector(safe_setObject:forKey:)];
    
    /*
    // ps虽然 dic[key]=nil object为nil不会崩溃，但是key为nil的话还是崩溃的
    // 不过综合的来说为了性能和key很少为nil，所以这里就不处理了
    [self swizzleInstanceMethodOfClass:NSClassFromString(@"__NSDictionaryM")
                      originalSelector:@selector(setObject:forKey:)
                      swizzledSelector:@selector(safe_setObject:forKeyedSubscript:)];
    */
}

- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!anObject || !aKey) {
        return;
    }
    
    return [self safe_setObject:anObject forKey:aKey];
}

- (void)safe_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!obj || !key) {
        return;
    }
    
    return [self safe_setObject:obj forKeyedSubscript:key];
}

@end



