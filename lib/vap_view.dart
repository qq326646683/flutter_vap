
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_vap/vap_view_for_android.dart';
import 'package:flutter_vap/vap_view_for_ios.dart';

class VapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return VapViewForAndroid();
    } else if (Platform.isIOS) {
      return VapViewForIos();
    }
    return Container();
  }
}
