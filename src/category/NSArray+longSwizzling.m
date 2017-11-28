//
//  NSArray+longSwizz.m
//  Pods-LongCrashDemo
//
//  Created by zilong.li on 2017/11/28.
//  Copyright © 2017年 zilong.li. All rights reserved.
//

#import "NSArray+longSwizzling.h"

#import <objc/runtime.h>

#import "LongCrashManager+listener.h"

@implementation NSArray (longSwizzling)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:)), class_getInstanceMethod([self class], @selector(swizz_instance_objectAtIndex:)));
    });
}

- (id)swizz_instance_objectAtIndex:(NSUInteger)index
{
    //避免数组越界造成crash
    if (self.count <= index) {
        NSInteger count = self.count != 0 ? self.count - 1 : 0;
        [[LongCrashManager sharedInstancel] onCrashWithInfo:[NSString stringWithFormat:@"LongCrash|NSRangeException-[__NSArrayI objectAtIndex:]: index %ld beyond bounds [0 .. %ld] %p|instance" ,index ,count, self]];
        return nil;
    }
    id ret = [self swizz_instance_objectAtIndex:index];
    return ret;
}

@end
