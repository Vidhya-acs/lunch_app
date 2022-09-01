import 'package:get/get.dart';
import 'package:lunch_app/bookin/booking_controller.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LunchBookingController());
  }
}
