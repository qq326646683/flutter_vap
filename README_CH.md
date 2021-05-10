### 背景
透明视频动画是目前比较流行的实现动画的一种, 大厂也相继开源自己的框架，最终我们选中[腾讯vap](https://github.com/Tencent/vap)，它支持了Android、IOS、Web，为我们封装flutter_vap提供了天然的便利，并且它提供了将帧图片生成带alpha通道视频的工具，这简直太赞了。


VAP（Video Animation Player）是企鹅电竞开发，用于播放酷炫动画的实现方案。
- 相比Webp, Apng动图方案，具有高压缩率(素材更小)、硬件解码(解码更快)的优点
- 相比Lottie，能实现更复杂的动画效果(比如粒子特效)

### 预览
![image](http://file.jinxianyun.com/flutter_vap.gif)

[video for youtube](https://youtu.be/OCLkFhcYqwA)

[video for qiniu](http://file.jinxianyun.com/flutter_vap.mp4)

[apk download](http://file.jinxianyun.com/flutter_vap.apk)

### 安装
```
flutter_vap: ${last_version}
```

### 使用

1. 播放本地视频
```dart
  import 'package:flutter_vap/flutter_vap.dart';

  /// return: play error:       {"status": "failure", "errorMsg": ""}
  ///         play complete:    {"status": "complete"}
  Future<Map<dynamic, dynamic>> _playFile(String path) async {
    if (path == null) {
      return null;
    }
    var res = await VapController.playPath(path);
    if (res["status"] == "failure") {
      showToast(res["errorMsg"]);
    }
    return res;
  }
```

2. 播放asset视频
```dart
  Future<Map<dynamic, dynamic>> _playAsset(String asset) async {
    if (asset == null) {
      return null;
    }
    var res = await VapController.playAsset(asset);
    if (res["status"] == "failure") {
      showToast(res["errorMsg"]);
    }
    return res;
  }
```

3. 停止播放
```dart
  VapController.stop()
```

4. 队列播放
```dart
  _queuePlay() async {
    // 模拟多个地方同时调用播放,使得队列执行播放。
    QueueUtil.get("vapQueue").addTask(() => VapController.playPath(downloadPathList[0]));
    QueueUtil.get("vapQueue").addTask(() => VapController.playPath(downloadPathList[1]));
  }
```

5. 取消队列播放
```dart
  QueueUtil.get("vapQueue").cancelTask();
```

### 例子
[github]()
