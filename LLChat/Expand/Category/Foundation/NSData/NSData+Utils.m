//
//  NSData+Utils.m
//  yunfutong
//
//  Created by jimi on 16/6/8.
//  Copyright © 2016年 jimi. All rights reserved.
//

#import "NSData+Utils.h"

@implementation NSData(Utils)
- (BOOL)isEmpty {
    BOOL result = NO;
    if ([self isKindOfClass:[NSNull class]] || 0 == self.length) {
        result = YES;
    }
    
    return result;
}
@end
