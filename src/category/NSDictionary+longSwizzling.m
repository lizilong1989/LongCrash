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
        Class __NSDictionaryM = objc_getClass("__NSDictionaryM");
        
        method_exchangeImplementations(class_getInstanceMethod(__NSDictionaryM, @selector(setObject:forKey:)), class_getInstanceMethod([self class], @selector(swizz_instance_setObject:forKey:)));
        
        method_exchangeImplementations(class_getInstanceMethod(__NSDictionaryM, @selector(removeObjectForKey:)), class_getInstanceMethod([self class], @selector(swizz_instance_removeObjectForKey:)));
        
        method_exchangeImplementations(class_getInstanceMethod(objc_getClass("__NSPlaceholderDictionary"), @selector(initWithObjects:forKeys:count:)), class_getInstanceMethod([self class], @selector(swizz_instance_initWithObjects:forKeys:count:)));
    });
}

#pragma mark - @selector(setObject:forKey:)

- (void)swizz_instance_setObject:(id)anObject forKey:(id)aKey;
{
    if (anObject == nil) {
        [[LongCrashManager sharedInstancel] onCrashWithClassName:[NSString stringWithFormat:@"%@", [self class]]
                                                    selectorName:@"setObject:forKey:"
                                                   exceptionName:[NSString stringWithFormat:@"object cannot be nil (key: %@)", aKey]
                                                         address:[NSString stringWithFormat:@"%p", self]
                                                      isInstance:YES
                                                callStackSymbols:[NSString stringWithFormat:@"%@", [NSThread callStackSymbols]]];
        return;
    }
    
    if (aKey == nil) {
        [[LongCrashManager sharedInstancel] onCrashWithClassName:[NSString stringWithFormat:@"%@", [self class]]
                                                    selectorName:@"setObject:forKey:"
                                                   exceptionName:@"key cannot be nil"
                                                         address:[NSString stringWithFormat:@"%p", self]
                                                      isInstance:YES
                                                callStackSymbols:[NSString stringWithFormat:@"%@", [NSThread callStackSymbols]]];
        
        return;
    }
    
    [self swizz_instance_setObject:anObject forKey:aKey];
}

#pragma mark - @selector(removeObjectForKey:)

- (void)swizz_instance_removeObjectForKey:(id)key
{
    if ( key != nil ) {
        [self swizz_instance_removeObjectForKey:key];
    } else {
        [[LongCrashManager sharedInstancel] onCrashWithClassName:[NSString stringWithFormat:@"%@", [self class]]
                                                    selectorName:@"removeObjectForKey:"
                                                   exceptionName:@"key cannot be nil"
                                                         address:[NSString stringWithFormat:@"%p", self]
                                                      isInstance:YES
                                                callStackSymbols:[NSString stringWithFormat:@"%@", [NSThread callStackSymbols]]];
    }
}

#pragma mark - @selector(initWithObjects:forKeys:count:)

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
            [[LongCrashManager sharedInstancel] onCrashWithClassName:[NSString stringWithFormat:@"%@", [self class]]
                                                        selectorName:@"initWithObjects:forKeys:count:"
                                                       exceptionName:[NSString stringWithFormat:@"attempt to insert nil object from objects[%d]" ,next]
                                                             address:[NSString stringWithFormat:@"%p", self]
                                                          isInstance:YES
                                                    callStackSymbols:[NSString stringWithFormat:@"%@", [NSThread callStackSymbols]]];
            return instance;
        }
    }
    
    instance = [self swizz_instance_initWithObjects:objects forKeys:keys count:cnt];
    return instance;
}

@end
