//
//  LongCrashManager.m
//  Pods-LongCrashDemo
//
//  Created by zilong.li on 2017/11/28.
//

#import "LongCrashManager.h"

#import "LongMulticastDelegate.h"

#import "NSArray+longSwizzling.h"
#import "NSObject+longSwizzling.h"
#import "NSDictionary+longSwizzling.h"

static LongCrashManager *instancel = nil;

@interface LongCrashManager ()
{
    LongMulticastDelegate<LongCrashDelegate> *_delegate;
}
@end;

@implementation LongCrashManager

+ (instancetype)sharedInstancel
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instancel = [[LongCrashManager alloc] init];
    });
    return instancel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegate = (LongMulticastDelegate<LongCrashDelegate> *)[[LongMulticastDelegate alloc] init];
        [NSObject long_crash];
        [NSArray long_crash];
        [NSDictionary long_crash];
    }
    return self;
}

#pragma mark - public

- (void)addDelegate:(id<LongCrashDelegate>)aDelegate
      delegateQueue:(dispatch_queue_t)aQueue
{
    if (aDelegate == nil) {
        return;
    }
    
    if ([aDelegate conformsToProtocol:@protocol(LongCrashDelegate)])
    {
        if (!aQueue) {
            aQueue = dispatch_get_main_queue();
        }
        [_delegate addDelegate:aDelegate delegateQueue:aQueue];
    }
}

- (void)removeDelegate:(id)aDelegate
{
    if (aDelegate == nil) {
        return;
    }
    [_delegate removeDelegate:_delegate];
}

@end

