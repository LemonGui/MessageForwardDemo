//
//  Son.m
//  消息转发 Demo
//
//  Created by Lemon on 16/11/3.
//  Copyright © 2016年 Lemon. All rights reserved.
//

#import "Son.h"
#import "Mother.h"
#import "Cooks.h"
#import <objc/runtime.h>
@implementation Son
//*********************************************   1   ******************************************
//消息转发调用步骤 -1 若该方法返回NO 进入 -2
//替换方法

//+(BOOL)resolveInstanceMethod:(SEL)sel{
//    NSString *methodName = NSStringFromSelector(sel);
//    if ([methodName isEqualToString:@"cook"]) {
//        class_addMethod([self class], sel, (IMP)myMethod,"v@:");
//        return YES;
//    }
//    //class_addmethod
//    //参数1：给谁添加
//    //参数2：添加的selector
//    //参数3：添加的imp实现
//    //参数4：方法的签名。"v@:" void类型的方法，没有参数传入。
//    //      “i@:” int类型的方法，没有参数传入。
//    //      ”i@:@” int类型的方法，又一个参数传入。
//    return [super resolveInstanceMethod:sel];
//}

void myMethod(id self, SEL _cmd) {
    NSLog(@"我被调用了");
}

//消息转发调用步骤 -2 返回nil 进入 -3
//替换对象 fast forwarding
//-(id)forwardingTargetForSelector:(SEL)aSelector{
//    
//    if ([Mother instancesRespondToSelector:aSelector]) {
//        return [Mother new];
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}


//************************************************    2    ***************************************
//标准转发
//消息转发调用步骤 -3  返回nil 抛出异常
//获取方法的签名
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
     NSMethodSignature * signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        if([Mother instancesRespondToSelector:aSelector])
        {
           signature = [Mother instanceMethodSignatureForSelector:aSelector];
        }
    }
    return signature;
}

//************************************************    3    **************************************
//在执行这个方法前会首先调用methodSignatureForSelector来请求一个签名，
//从而生成一个NSInvocation，对消息进行完全转发。
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    if ([Mother instancesRespondToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:[[Mother alloc] init]];
    }
    
    if ([Cooks instancesRespondToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:[[Cooks alloc] init]];
    }
}



@end
