#import "FlutterChairaPlugin.h"
#import <flutter_chaira/flutter_chaira-Swift.h>

@implementation FlutterChairaPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterChairaPlugin registerWithRegistrar:registrar];
}
@end
