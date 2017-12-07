//
//  LongCrashManager+listener.h
//  Pods-LongCrashDemo
//
//  Created by zilong.li on 2017/11/28.
//

#import "LongCrashManager.h"

@interface LongCrashManager (listener)

- (void)onCrashWithInfo:(NSString*)aInfo;

- (void)onCrashWithClassName:(NSString*)aClassName
                selectorName:(NSString*)aSelectorName
               exceptionName:(NSString*)aExceptionName
                     address:(NSString*)aAddress
                  isInstance:(BOOL)aIsInstance
            callStackSymbols:(NSString*)aCallStackSymbols;

@end
