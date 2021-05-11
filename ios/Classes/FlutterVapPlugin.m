#import "FlutterVapPlugin.h"
#import "NativeVapView.h"

@implementation FlutterVapPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  
    NativeVapViewFactory* factory = [[NativeVapViewFactory alloc] initWithRegistrar: registrar];
    [registrar registerViewFactory:factory withId:@"flutter_vap"];
    
}



@end
