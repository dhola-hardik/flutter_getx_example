import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Constants constants = Constants();

final title = "Constants";

class Constants {
  static final Constants _constants = Constants._i();

  factory Constants() {
    return _constants;
  }

  Constants._i();

  bool isKeyboardOpened() {
    return MediaQuery.of(Get.context!).viewInsets.bottom != 0;
  }

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  void dismissKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void dismissSnakbar() {
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
  }
}
