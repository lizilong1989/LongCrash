//
//  NSObject+longSwizz.m
//  LongCrashDemo
//
//  Created by zilong.li on 2017/11/24.
//  Copyright © 2017年 zilong.li. All rights reserved.
//

#import "NSObject+longSwizzling.h"

#import <objc/runtime.h>

#import "LongCrashManager.h"
#import "LongCrashManager+listener.h"

@implementation NSObject (longSwizz)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod([NSObject class], @selector(forwardInvocation:)), class_getInstanceMethod([self class], @selector(swizz_instance_forwardInvocation:)));
        
        method_exchangeImplementations(class_getInstanceMethod([NSObject class], @selector(methodSignatureForSelector:)), class_getInstanceMethod([self class], @selector(swizz_instance_methodSignatureForSelector:)));
        
        method_exchangeImplementations(class_getClassMethod([NSObject class], @selector(forwardInvocation:)), class_getClassMethod([self class], @selector(swizz_class_forwardInvocation:)));
        
        method_exchangeImplementations(class_getClassMethod([NSObject class], @selector(methodSignatureForSelector:)), class_getClassMethod([self class], @selector(swizz_class_methodSignatureForSelector:)));
    });
}

void dynamicMethodIMP(id self, SEL _cmd) {
    //do nothing
}

- (NSMethodSignature *)swizz_instance_methodSignatureForSelector:(SEL)aSelector {
    
    NSMethodSignature *sig = [self swizz_instance_methodSignatureForSelector:aSelector];
    if (sig == nil) {
        if (![[LongCrashManager sharedInstancel] respondsToSelector:aSelector]) {
            class_addMethod([LongCrashManager class], aSelector, (IMP)dynamicMethodIMP, "v@:");
        }
        sig = [[LongCrashManager sharedInstancel] methodSignatureForSelector:aSelector];
        [[LongCrashManager sharedInstancel] onCrashWithInfo:[NSString stringWithFormat:@"unrecognized-[class:%@]-[sel:%@]" ,[self class] ,NSStringFromSelector(aSelector)]];
    }
    return sig;
}

- (void)swizz_instance_forwardInvocation:(NSInvocation *)aInvocation
{
    id target = nil;
    if ([[LongCrashManager sharedInstancel] methodSignatureForSelector:[aInvocation selector]] ) {
        target = [LongCrashManager sharedInstancel];
        [aInvocation invokeWithTarget:target];
    } else {
        [self swizz_instance_forwardInvocation:aInvocation];
    }
}

- (NSMethodSignature *)swizz_class_methodSignatureForSelector:(SEL)aSelector {
    
    NSMethodSignature *sig = [self swizz_class_methodSignatureForSelector:aSelector];
    if (sig == nil) {
        if (![[LongCrashManager sharedInstancel] respondsToSelector:aSelector]) {
            class_addMethod([LongCrashManager class], aSelector, (IMP)dynamicMethodIMP, "v@:");
        }
        sig = [[LongCrashManager sharedInstancel] methodSignatureForSelector:aSelector];
        [[LongCrashManager sharedInstancel] onCrashWithInfo:[NSString stringWithFormat:@"unrecognized-[class:%@]-[sel:%@]" ,[self class] ,NSStringFromSelector(aSelector)]];
    }
    return sig;
}

- (void)swizz_class_forwardInvocation:(NSInvocation *)aInvocation
{
    id target = nil;
    if ([[LongCrashManager sharedInstancel] methodSignatureForSelector:[aInvocation selector]] ) {
        target = [LongCrashManager sharedInstancel];
        [aInvocation invokeWithTarget:target];
    } else {
        [self swizz_class_forwardInvocation:aInvocation];
    }
}

@end
