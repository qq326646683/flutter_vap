
#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "UIView+VAP.h"
#import "QGVAPWrapView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NativeVapViewFactory : NSObject <FlutterPlatformViewFactory>
- (instancetype)initWithRegistrar: (NSObject<FlutterPluginRegistrar> *) registrar;
@end

@interface NativeVapView : NSObject <FlutterPlatformView, VAPWrapViewDelegate>

- (instancetype)initWithFrame: (CGRect) frame
               viewIdentifier: (int64_t) viewId
                    arguments: (id _Nullable) args
                    mRegistrar: (NSObject<FlutterPluginRegistrar> *) registrar;

- (UIView*) view;

@end

NS_ASSUME_NONNULL_END
