//
//  TTRefreshHeader.m
//  YDTicketTong
//
//  Created by alex on 17/1/12.
//  Copyright © 2017年 alex. All rights reserved.
//

#import "TTRefreshHeader.h"

@implementation TTRefreshHeader

+ (instancetype)ttHeaderWithRefreshBlock:(MJRefreshComponentRefreshingBlock)block {
    
    TTRefreshHeader *refreshHeader = [TTRefreshHeader headerWithRefreshingBlock:block];
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    return refreshHeader;
}


@end
