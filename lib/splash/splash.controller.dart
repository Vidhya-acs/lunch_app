import 'dart:async';
import 'package:get/get.dart';
import 'package:lunch_app/app_paths/app_path.dart';
import 'package:lunch_app/login.dart/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  initial() async {
    SharedPreferences appSharedPreference;
    appSharedPreference = await SharedPreferences.getInstance();
    var key = appSharedPreference.getString('userkey');
    Timer(
        const Duration(seconds: 3),
        () => key != null
            ? Get.offNamed(AppPath.home)
            : Get.offNamed(AppPath.login));
  }
}
