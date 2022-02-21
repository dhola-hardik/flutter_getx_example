import 'package:flutter/material.dart';
import 'package:flutter_getx_example/controllers/app_controller.dart';
import 'package:flutter_getx_example/data/common/params_args.dart';
import 'package:get/get.dart';

class MyApplication {
  static GlobalKey<NavigatorState>? _navigatorKey;
  static AppController _appController = Get.find(tag: ParamsArgus.APP);

  MyApplication() {
    if (navigatorKey != null) {
      _navigatorKey = navigatorKey;
    } else {
      _navigatorKey = GlobalKey<NavigatorState>();
    }
    if (_appController == null) {
      _appController = Get.find(tag: ParamsArgus.APP);
    }
  }

  static GlobalKey<NavigatorState>? get navigatorKey {
    return _navigatorKey;
  }

  static AppController get appController {
    return _appController;
  }
}
