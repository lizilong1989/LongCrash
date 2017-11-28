//
//  NSDictionary+longSwizzling.m
//  LongCrashDemo
//
//  Created by zilong.li on 2017/11/28.
//  Copyright © 2017年 zilong.li. All rights reserved.
//

#import "NSDictionary+longSwizzling.h"

#import <objc/runtime.h>

#import "LongCrashManager+listener.h"

@implementation NSDictionary (longSwizzling)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:)), class_getInstanceMethod([self class], @selector(swizz_instance_setObject:forKey:)));
    });
}

- (void)swizz_instance_setObject:(id)anObject forKey:(id)aKey;
{
    if (anObject == nil) {
        [[LongCrashManager sharedInstancel] onCrashWithInfo:[NSString stringWithFormat:@"LongCrash|[__NSDictionaryM setObject:forKey:]: object cannot be nil (key: %@) %p|instance" ,aKey ,self]];
        return;
    }
    
    if (aKey == nil) {
        [[LongCrashManager sharedInstancel] onCrashWithInfo:[NSString stringWithFormat:@"LongCrash|[__NSDictionaryM setObject:forKey:]: key cannot be nil %p|instance" ,self]];
        return;
    }
    
    [self swizz_instance_setObject:anObject forKey:aKey];
}

@end
