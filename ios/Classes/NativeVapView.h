
#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface NativeVapViewFactory : NSObject <FlutterPlatformViewFactory>
- (instancetype)initWithRegistrar: (NSObject<FlutterPluginRegistrar> *) registrar;
@end


NS_ASSUME_NONNULL_END
