# LongCrash

这是一个简单避免app crash的框架；随着app不断的迭代，代码会变得越来越多，经过N个人的持续N年的代码，维护起来越来越难，也很难保证测试case覆盖所有场景。举一个例子如果原来服务器返回的是数组，而现在返回字符串，如果代码上没有添加判断，很可能就会造成“unrecognized selector sent to instance”，谁也不知道当初这么写的逻辑，没人敢动老代码。几万甚至数十万行的代码，这样的风险不可避免。

此项目希望尽量对源代码少的改动，增加程序的健壮性，避免由于异常情况导致的crash

## 集成
1.使用 Cocoapods 来集成LongCrash, 集成方法如下:

```
pod 'LongCrash'
```

## 使用方法

LongCrash使用方法

```

#import "LongCrashManager.h"

@interface AppDelegate () <LongCrashDelegate>

@end

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

	//注册回调
	[[LongCrashManager sharedInstancel] addDelegate:self delegateQueue:nil];
}

#pragma mark - LongCrashDelegate

- (void)didCrashWithInfo:(NSString *)aInfo
{
    NSLog(@"%@",aInfo);
}
```

## 运行Demo

进入LongCrashDemo路径下执行，点击LongCrashDemo.xcworkspace即可运行

```
pod install
```

## Relase Note

###v1.0.0
* 避免app因unrecognized selector引起crash