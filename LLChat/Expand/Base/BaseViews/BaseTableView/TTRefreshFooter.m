//
//  TTRefreshFooter.m
//  YDTicketTong
//
//  Created by alex on 17/1/22.
//  Copyright © 2017年 alex. All rights reserved.
//

#import "TTRefreshFooter.h"

@implementation TTRefreshFooter

+ (instancetype)ttFooterWithRefreshBlock:(MJRefreshComponentRefreshingBlock)block {
    TTRefreshFooter *footer = [TTRefreshFooter footerWithRefreshingBlock:block];
    [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    return footer;
}

@end
