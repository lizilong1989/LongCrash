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

+ (void)long_crash
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:)), class_getInstanceMethod([self class], @selector(swizz_instance_setObject:forKey:)));
        
        method_exchangeImplementations(class_getInstanceMethod(objc_getClass("__NSPlaceholderDictionary"), @selector(initWithObjects:forKeys:count:)), class_getInstanceMethod([self class], @selector(swizz_instance_initWithObjects:forKeys:count:)));
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

- (instancetype)swizz_instance_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt
{
    id instance = nil;
    if (cnt > 0) {
        bool ret = YES;
        int next = 0;
        while ( next < cnt ) {
            if (objects[next] == nil) {
                ret = NO;
                break;
            }
            if (keys[next] == nil) {
                ret = NO;
                break;
            }

            next++;
        }
        if (!ret) {
            [[LongCrashManager sharedInstancel] onCrashWithInfo:[NSString stringWithFormat:@"LongCrash|[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[%d] %p|instance" ,next ,self]];
            return instance;
        }
    }
    
    instance = [self swizz_instance_initWithObjects:objects forKeys:keys count:cnt];
    return instance;
}

@end
