//
//  LongCrashManager+listener.h
//  Pods-LongCrashDemo
//
//  Created by zilong.li on 2017/11/28.
//

#import "LongCrashManager.h"

@interface LongCrashManager (listener)

- (void)onCrashWithInfo:(NSString*)aInfo;

@end
