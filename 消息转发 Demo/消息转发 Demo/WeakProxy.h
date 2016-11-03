//
//  WeakProxy.h
//  消息转发 Demo
//
//  Created by Lemon on 16/11/3.
//  Copyright © 2016年 Lemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeakProxy : NSProxy
@property (weak,nonatomic,readonly)id target;
+ (instancetype)proxyWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;
@end
