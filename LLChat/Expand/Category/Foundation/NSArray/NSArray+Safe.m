//
//  NSArray+Safe.m
//  TestSafeCollection
//
//  Created by 席萍萍 on 2016/11/10.
//  Copyright © 2016年 Yundi. All rights reserved.
//

#import "NSArray+Safe.h"

#import "NSObject+Swizzle.h"


@implementation NSArray (Safe)

+ (void)load {
    [self swizzleInstanceMethodOfClass:objc_getClass("__NSArrayI")
                      originalSelector:@selector(objectAtIndex:)
                      swizzledSelector:@selector(safeI_ObjectsAtIndex:)];
    
    [self swizzleInstanceMethodOfClass:objc_getClass("__NSArray0")
                      originalSelector:@selector(objectAtIndex:)
                      swizzledSelector:@selector(safe0_ObjectsAtIndex:)];
    
    [self swizzleInstanceMethodOfClass:objc_getClass("__NSArrayM")
                      originalSelector:@selector(objectAtIndex:)
                      swizzledSelector:@selector(safeM_ObjectsAtIndex:)];
    
    [self swizzleInstanceMethodOfClass:objc_getClass("__NSSingleObjectArrayI")
                      originalSelector:@selector(objectAtIndex:)
                      swizzledSelector:@selector(safeI_single_ObjectsAtIndex:)];
    
    
    [self swizzleInstanceMethodOfClass:objc_getClass("__NSPlaceholderArray")
                      originalSelector:@selector(initWithObjects:count:)
                      swizzledSelector:@selector(safe_initWithObjects:count:)];
}

- (id)safe_initWithObjects:(const id _Nonnull __unsafe_unretained *)objects count:(NSUInteger)count {
    
    BOOL hasNil = NO;
    for (NSUInteger i = 0; i < count; ++i) {
        if (!objects[i]) {
            hasNil = YES;
            break;
        }
    }
    
    if (hasNil) {
        id __unsafe_unretained newObjects[count];
        int j = 0;
        for (NSUInteger i = 0; i < count; ++i) {
            if (objects[i]) {
                newObjects[j] = objects[i];
                j++;
            }
        }
        
        if (j==0) {
            return nil;
        }
        
        return [self safe_initWithObjects:newObjects count:j];
    }
    
    return [self safe_initWithObjects:objects count:count];
}

#pragma mark - swizzled
- (id)safeI_ObjectsAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self safeI_ObjectsAtIndex:index];
    }else{
        return nil;
    }
}

- (id)safeI_single_ObjectsAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self safeI_single_ObjectsAtIndex:index];
    }else{
        return nil;
    }
}

- (id)safe0_ObjectsAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self safe0_ObjectsAtIndex:index];
    }else{
        return nil;
    }
}

- (id)safeM_ObjectsAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self safeM_ObjectsAtIndex:index];
    }else{
        return nil;
    }
}

@end


@interface NSMutableArray (Safe)

@end

@implementation NSMutableArray (Safe)

+ (void)load {
    [self swizzleInstanceMethodOfClass:NSClassFromString(@"__NSArrayM")
                      originalSelector:@selector(addObject:)
                      swizzledSelector:@selector(safe_addObject:)];
    
    [self swizzleInstanceMethodOfClass:NSClassFromString(@"__NSArrayM")
                      originalSelector:@selector(insertObject:atIndex:)
                      swizzledSelector:@selector(safe_insertObject:atIndex:)];
    
    [self swizzleInstanceMethodOfClass:NSClassFromString(@"__NSArrayM")
                      originalSelector:@selector(replaceObjectAtIndex:withObject:)
                      swizzledSelector:@selector(safe_replaceObjectAtIndex:withObject:)];
    
}


- (void)safe_addObject:(id)anObject {
    if (anObject) {
        [self safe_addObject:anObject];
    }
}

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject && index <= self.count) {
        [self safe_insertObject:anObject atIndex:index];
    }
}

- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (anObject && index < self.count) {
        [self safe_replaceObjectAtIndex:index withObject:anObject];
    }
}


@end

