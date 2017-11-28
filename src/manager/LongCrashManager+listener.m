//
//  LongCrashManager+listener.m
//  Pods-LongCrashDemo
//
//  Created by zilong.li on 2017/11/28.
//

#import "LongCrashManager+listener.h"

#import <objc/runtime.h>

#import "LongMulticastDelegate.h"

@implementation LongCrashManager (listener)

- (void)onCrashWithInfo:(NSString*)aInfo
{
    Ivar ivar = class_getInstanceVariable([LongCrashManager class], "_delegate");
    if (ivar) {
        LongMulticastDelegate<LongCrashDelegate> *delegate = (LongMulticastDelegate<LongCrashDelegate> *)object_getIvar([LongCrashManager sharedInstancel], ivar);
        if (delegate) {
            [delegate didCrashWithInfo:aInfo];
        }
    }
}

@end
