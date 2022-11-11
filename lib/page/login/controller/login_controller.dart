import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }

}

class LoginController extends GetxController{

}