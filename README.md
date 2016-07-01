# ORGProtocolExtension

## sample code

```
#import "AppDelegate.h"

#import "ORGProtocolExtension.h"
#import "ORGProtocolExtensionDefinition.h"

@protocol MyProtocol <NSObject>
@optional
- (void)func:(NSString*)param;
@end

@interface AppDelegate () < MyProtocol >
@property(nonatomic, nullable, strong) ORGProtocolExtension *protocolExtension;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // あるプロトコルの関数を実行時に定義し、
    // その関数をプロトコルに対応する全てのクラスに動的に追加します
    ORGProtocolExtensionDefinition *d = [ORGProtocolExtensionDefinition definitionWithProtocolName:@"MyProtocol"];
    [d addImplementationWithSelectorString:@"func:"
                                     block:^(id caller, NSString *param)
    {
        NSLog(@"caller : %@", caller);
        NSLog(@"param : %@", param);
    }];
    self.protocolExtension = [[ORGProtocolExtension alloc] init];
    [self.protocolExtension addDefinition:d];
    [self.protocolExtension apply];
    
    // プロトコルに基づき動的に追加された関数を呼び出す
    [self func:@"HELLO ORGProtocolExtension!!"]; // caller : <AppDelegate: 0x174025800>
                                                 // param : HELLO ORGProtocolExtension!!
    return YES;
}
``` 
