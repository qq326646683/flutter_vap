
#import "NativeVapView.h"
#import "UIView+VAP.h"

@implementation NativeVapViewFactory {
    NSObject<FlutterPluginRegistrar> * _registrar;
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    self = [super init];
    if (self) {
        _registrar = registrar;
    }
    return self;
}

- (NSObject<FlutterPlatformView> *)createWithFrame: (CGRect) frame
                                    viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    return [[NativeVapView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args mRegistrar:_registrar];
}

@end

@implementation NativeVapView {
    UIView *_view;
}

- (instancetype)initWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args mRegistrar:(NSObject<FlutterPluginRegistrar> *) registrar {
    if (self == [super init]) {
        _view = [[UIView alloc] init];
        
        FlutterMethodChannel* channel = [FlutterMethodChannel
            methodChannelWithName:@"flutter_vap_controller"
                  binaryMessenger:registrar.messenger];
        
        [registrar addMethodCallDelegate: self channel:channel];
        
    }
    return self;
}

#pragma mark --flutter调native回调
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"playPath" isEqualToString: call.method]) {
        NSString *filePath = [call.arguments objectForKey: @"path"];
        
        VAPView *mp4View = [[VAPView alloc] initWithFrame:CGRectMake(0, 0, 752/2, 752/2)];
        mp4View.center = self.view.center;
        [_view addSubview: mp4View];

        [mp4View playHWDMP4:filePath repeatCount: 0 delegate: self];
        
    }
}

#pragma mark --播放回调
- (void) viewDidStartPlayMP4:(VAPView *)container {
    NSLog(@"nell-viewDidStartPlayMP4");
}

- (void) viewDidFinishPlayMP4:(NSInteger)totalFrameCount view:(VAPView *)container {
    NSLog(@"nell-viewDidFinishPlayMP4");
}

- (void) viewDidPlayMP4AtFrame:(QGMP4AnimatedImageFrame *)frame view:(VAPView *)container {
    NSLog(@"nell-viewDidPlayMP4AtFrame");
}

- (void) viewDidStopPlayMP4:(NSInteger)lastFrameIndex view:(VAPView *)container {
    NSLog(@"nell-viewDidStopPlayMP4");
    dispatch_async(dispatch_get_main_queue(), ^{
        [container removeFromSuperview];
    });
}

- (BOOL) shouldStartPlayMP4:(VAPView *)container config:(QGVAPConfigModel *)config {
    NSLog(@"nell-shouldStartPlayMP4");
    return YES;
}

- (void) viewDidFailPlayMP4:(NSError *)error {
    NSLog(@"nell-viewDidFailPlayMP4:%@", error.userInfo);
}

- (UIView*)view {
    return _view;
}

@end
