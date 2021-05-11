import 'package:flutter/widgets.dart';

class VapViewForIos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType: "flutter_vap",
      layoutDirection: TextDirection.ltr,
    );
  }
}
