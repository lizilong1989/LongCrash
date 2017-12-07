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

- (void)onCrashWithClassName:(NSString*)aClassName
                selectorName:(NSString*)aSelectorName
               exceptionName:(NSString*)aExceptionName
                     address:(NSString*)aAddress
                  isInstance:(BOOL)aIsInstance
            callStackSymbols:(NSString*)aCallStackSymbols
{
    Ivar ivar = class_getInstanceVariable([LongCrashManager class], "_delegate");
    if (ivar) {
        LongMulticastDelegate<LongCrashDelegate> *delegate = (LongMulticastDelegate<LongCrashDelegate> *)object_getIvar([LongCrashManager sharedInstancel], ivar);
        NSString *aInfo = [NSString stringWithFormat:@"LongCrash|[%@ %@]|%@|%p|%@|%@" ,aClassName ,aSelectorName, aExceptionName ,aAddress ,aIsInstance?@"instance":@"class" ,self.isPrintCallStack?aCallStackSymbols:@""];
        if (delegate) {
            [delegate didCrashWithInfo:aInfo];
        }
    }
}

@end
