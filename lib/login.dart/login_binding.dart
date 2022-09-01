import 'package:get/get.dart';
import 'package:lunch_app/login.dart/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
