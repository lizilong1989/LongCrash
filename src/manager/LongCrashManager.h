//
//  LongCrashManager.h
//  Pods-LongCrashDemo
//
//  Created by zilong.li on 2017/11/28.
//

#import <Foundation/Foundation.h>

@protocol LongCrashDelegate <NSObject>

@optional

/*!
 *  框架避免出现crash的回调
 *
 *  @param aInfo    具体导致crash的信息
 */
- (void)didCrashWithInfo:(NSString*)aInfo;

@end

@interface LongCrashManager : NSObject

/*!
 *  获取SDK实例
 */
+ (instancetype)sharedInstancel;

/*!
 *  添加回调代理
 *
 *  @param aDelegate  要添加的代理
 *  @param aQueue     执行代理方法的队列
 */
- (void)addDelegate:(id<LongCrashDelegate>)aDelegate
      delegateQueue:(dispatch_queue_t)aQueue;

/*!
 *  移除回调代理
 *
 *  @param aDelegate  要移除的代理
 */
- (void)removeDelegate:(id)aDelegate;

@end
