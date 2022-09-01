import 'package:get/get.dart';
import 'package:lunch_app/view_order/view_order_controller.dart';

class ViewOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewOrderController());
  }
}
