
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/api_fetch/controller.dart';

class RootBindings implements Bindings {

  @override
  void dependencies() {

    Get.put(HomeController());
  }}