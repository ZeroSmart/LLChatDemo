//
//  TTRefreshHeader.h
//  YDTicketTong
//
//  Created by alex on 17/1/12.
//  Copyright © 2017年 alex. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface TTRefreshHeader : MJRefreshNormalHeader


+ (instancetype)ttHeaderWithRefreshBlock:(MJRefreshComponentRefreshingBlock)block;

@end
