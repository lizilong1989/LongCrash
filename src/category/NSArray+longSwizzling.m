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

+ (void)long_crash
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSArrayI = objc_getClass("__NSArrayI");
        Class __NSSingleObjectArrayI = objc_getClass("__NSSingleObjectArrayI");
        Class __NSArray0 = objc_getClass("__NSArray0");
        Class __NSPlaceholderArray = objc_getClass("__NSPlaceholderArray");
        
        method_exchangeImplementations(class_getInstanceMethod(__NSArrayI, @selector(objectAtIndex:)), class_getInstanceMethod([self class], @selector(swizz_instance_NSArrayI_objectAtIndex:)));
        
        method_exchangeImplementations(class_getInstanceMethod(__NSArray0, @selector(objectAtIndex:)), class_getInstanceMethod([self class], @selector(swizz_instance_NSArray0_objectAtIndex:)));
        
        method_exchangeImplementations(class_getInstanceMethod(__NSSingleObjectArrayI, @selector(objectAtIndex:)), class_getInstanceMethod([self class], @selector(swizz_instance_NSSingleObjectArrayI_objectAtIndex:)));
        
        method_exchangeImplementations(class_getInstanceMethod(__NSPlaceholderArray, @selector(initWithObjects:count:)), class_getInstanceMethod([self class], @selector(swizz_instance_initWithObjects:count:)));
    });
}

#pragma mark - @selector(initWithObjects:count:)

- (instancetype)swizz_instance_initWithObjects:(const id _Nonnull [_Nullable])objects count:(NSUInteger)cnt
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
            next++;
        }
        if (!ret) {
            [[LongCrashManager sharedInstancel] onCrashWithClassName:[NSString stringWithFormat:@"%@", [self class]]
                                                        selectorName:@"initWithObjects:count:"
                                                       exceptionName:[NSString stringWithFormat:@"attempt to insert nil object from objects[%d]" ,next]
                                                             address:[NSString stringWithFormat:@"%p", self]
                                                          isInstance:YES
                                                    callStackSymbols:[NSString stringWithFormat:@"%@", [NSThread callStackSymbols]]];
            return instance;
        }
    }
    
    instance = [self swizz_instance_initWithObjects:objects count:cnt];
    return instance;
}

#pragma mark - @selector(objectAtIndex:)

- (id)swizz_instance_NSArrayI_objectAtIndex:(NSUInteger)index
{
    //避免数组越界造成crash
    if (self.count <= index) {
        NSInteger count = self.count != 0 ? self.count - 1 : 0;
        [[LongCrashManager sharedInstancel] onCrashWithClassName:[NSString stringWithFormat:@"%@", [self class]]
                                                    selectorName:@"objectAtIndex:"
                                                   exceptionName:[NSString stringWithFormat:@"index %ld beyond bounds [0 .. %ld]" ,index ,count]
                                                         address:[NSString stringWithFormat:@"%p", self]
                                                      isInstance:YES
                                                callStackSymbols:[NSString stringWithFormat:@"%@", [NSThread callStackSymbols]]];
        
        return nil;
    }
    id ret = [self swizz_instance_NSArrayI_objectAtIndex:index];
    return ret;
}

- (id)swizz_instance_NSArray0_objectAtIndex:(NSUInteger)index
{
    //避免数组越界造成crash
    if (self.count <= index) {
        NSInteger count = self.count != 0 ? self.count - 1 : 0;
        [[LongCrashManager sharedInstancel] onCrashWithClassName:[NSString stringWithFormat:@"%@", [self class]]
                                                    selectorName:@"objectAtIndex:"
                                                   exceptionName:[NSString stringWithFormat:@"index %ld beyond bounds [0 .. %ld]" ,index ,count]
                                                         address:[NSString stringWithFormat:@"%p", self]
                                                      isInstance:YES
                                                callStackSymbols:[NSString stringWithFormat:@"%@", [NSThread callStackSymbols]]];
        
        return nil;
    }
    id ret = [self swizz_instance_NSArray0_objectAtIndex:index];
    return ret;
}

- (id)swizz_instance_NSSingleObjectArrayI_objectAtIndex:(NSUInteger)index
{
    //避免数组越界造成crash
    if (self.count <= index) {
        NSInteger count = self.count != 0 ? self.count - 1 : 0;
        [[LongCrashManager sharedInstancel] onCrashWithClassName:[NSString stringWithFormat:@"%@", [self class]]
                                                    selectorName:@"objectAtIndex:"
                                                   exceptionName:[NSString stringWithFormat:@"index %ld beyond bounds [0 .. %ld]" ,index ,count]
                                                         address:[NSString stringWithFormat:@"%p", self]
                                                      isInstance:YES
                                                callStackSymbols:[NSString stringWithFormat:@"%@", [NSThread callStackSymbols]]];
        
        return nil;
    }
    id ret = [self swizz_instance_NSSingleObjectArrayI_objectAtIndex:index];
    return ret;
}

@end
