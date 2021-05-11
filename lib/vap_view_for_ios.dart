import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class VapViewForIos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{};
    return UiKitView(
      viewType: "flutter_vap",
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: StandardMessageCodec(),
    );
  }
}
