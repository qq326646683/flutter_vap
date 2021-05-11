#import "FlutterVapPlugin.h"
#import <AVFoundation/AVFoundation.h>

@interface FlutterVapPlugin ()
@property(readonly, strong, nonatomic) NSObject<FlutterPluginRegistrar>* registrar;
@property(nonatomic, strong) VAPView *mp4View;
@end

@implementation FlutterVapPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_vap_controller"
            binaryMessenger:[registrar messenger]];
  FlutterVapPlugin* instance = [[FlutterVapPlugin alloc] initWithRegistrar:registrar];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  self = [super init];
  _registrar = registrar;
  return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"playPath" isEqualToString:call.method]) {
        //播放路径文件
        [self playPath:call.arguments[@"path"]];
    } else if ([@"playAsset" isEqualToString:call.method]) {
        //播放asset文件
        NSString* assetPath = [_registrar lookupKeyForAsset:call.arguments[@"asset"]];
        NSString* path11 = [[NSBundle mainBundle] pathForResource:assetPath ofType:nil];
        [self playPath:path11];
    } else if ([@"stop" isEqualToString:call.method]) {
        //停止
        [self stop];
    }
}

- (void)playPath:(NSString *)path {
    
    UIViewController *rootViewController =
        [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    _mp4View = [[VAPView alloc] initWithFrame:CGRectMake(0, 0, 752/2, 752/2)];
    //默认使用metal渲染，使用OpenGL请打开下面这个开关
    //mp4View.renderByOpenGL = YES;
    _mp4View.center = rootViewController.view.center;
    [rootViewController.view addSubview:_mp4View];
    _mp4View.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageviewTap:)];
    [_mp4View addGestureRecognizer:tap];
    //单纯播放的接口
    //[mp4View playHWDMp4:resPath];
    //指定素材混合模式，重复播放次数，delegate的接口
    [_mp4View playHWDMP4:path repeatCount:0 delegate:self];
}

- (void)stop{
    if (_mp4View) {
        [_mp4View removeFromSuperview];
    }
}

- (void)onImageviewTap:(UIGestureRecognizer *)ges {
    
    [ges.view removeFromSuperview];
}

@end
