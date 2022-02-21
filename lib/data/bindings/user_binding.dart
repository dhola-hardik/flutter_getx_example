import 'package:flutter_getx_example/controllers/app_controller.dart';
import 'package:flutter_getx_example/data/common/params_args.dart';
import 'package:get/get.dart';

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppController(), tag: ParamsArgus.APP, fenix: true);
  }
}
