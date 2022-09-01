import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_app/app_paths/app_path.dart';
import 'package:lunch_app/setting/api_url.dart';
import 'package:ntp/ntp.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var loggedUserName = ''.obs;
  // var CurentbookingCount = 0.obs;
  var curentPayable = 0.obs;
  var currentMonthName = ''.obs;
  var previousMonthName = ''.obs;
  var previousMonthBookingCount = 0.obs;
  var previousMonthPayableCount = 0.obs;
  var currentFoodCount = 0.obs;
  var previousFoodCount = 0.obs;
  var previousFoodPayable = 0.obs;

  storedKey() async {
    SharedPreferences appSharedPreference;
    appSharedPreference = await SharedPreferences.getInstance();
    var key = appSharedPreference.getString('userkey');
    return key;
  }

  @override
  void onInit() {
    super.onInit();
  }

  initial() async {
    SharedPreferences appSharedPreference;
    appSharedPreference = await SharedPreferences.getInstance();
    var firstName = await appSharedPreference.getString('username');
    loggedUserName.value = firstName as String;
    currentMonthbookedLunch();
    previousMonthApi();
    print(loggedUserName.value);
  }

  timeChecking() async {
    DateTime actualTime = await NTP.now();
    DateTime deviceTime = DateTime.now().toLocal();
    String deviceDate = DateFormat("dd_MM_yyyy").format(deviceTime);
    String actualDate = DateFormat("dd_MM_yyyy").format(actualTime);
    DateTime currentTime = DateTime.now();

    if (actualDate.compareTo(deviceDate) == 0) {
      if (currentTime.isAfter(DateTime(
              currentTime.year, currentTime.month, currentTime.day, 1, 0, 0)) &&
          (currentTime.isBefore(DateTime(currentTime.year, currentTime.month,
              currentTime.day, 11, 20, 0)))) {
        Get.toNamed(AppPath.booking);
      } else {
        Get.snackbar('Time up!', 'Please book before 11.20',
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
            icon: Icon(Icons.lock_clock),
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  currentMonthbookedLunch() async {
    var currentMonth = DateFormat.MMMM().format(DateTime.now());
    currentMonthName.value = currentMonth;
    var key = await storedKey();
    try {
      final response = await http.get(
          Uri.parse(Settings.baseUrl + Settings.currentMonthCheckBookingUrl),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Basic $key",
          });
      if (response.statusCode == 200) {
        var responseContent = json.decode(response.body);
        // bookingCount.value = responseContent['total_count'];
        // payable.value = responseContent['total_count'] * 10;
        var timeEntry = responseContent['time_entries'];
        Set foodCount = {};
        for (var spendOn in timeEntry) {
          foodCount.add(spendOn['spent_on']);
        }
        currentFoodCount.value = foodCount.length;
        curentPayable.value = foodCount.length * 10;
      }
    } catch (e) {
      throw Exception();
    }
  }

  previousMonthApi() async {
    var key = await storedKey();

    DateTime currentDate = DateTime.now();
    var previousMonth = DateFormat("yyyy-MM-dd")
        .format(DateTime(currentDate.year, currentDate.month - 1, 1));
    var prev =
        DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
    var previousMonthFormat = DateFormat.MMMM().format(prev);
    previousMonthName.value = previousMonthFormat;
    try {
      final response = await http.get(
          Uri.parse(Settings.baseUrl + Settings.previousMonthCheckBookingUrl),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Basic $key",
          });
      if (response.statusCode == 200) {
        var responseContent = json.decode(response.body);
        var timeEntries = responseContent['time_entries'];
        Set previousFilteredFood = {};
        for (var spendOn in timeEntries) {
          previousFilteredFood.add(spendOn['spent_on']);
        }
        previousFoodCount.value = previousFilteredFood.length;
        previousFoodPayable.value = previousFilteredFood.length * 10;
      }
    } catch (e) {
      throw Exception();
    }
  }

  // currentMonthfilterFoodCount() {
  //   var timeEntries = currentMonthbookedLunch();
  //   Set foodCount = {};
  //   for (var spendOn in timeEntries) {
  //     foodCount.add(spendOn['spent_on']);
  //   }
  //   currentFoodCount.value = foodCount.length;
  // }

//   previousMonthfilterFoodCount() {
//     var timeEntries = previousMonthApi();
//     Set previousFilteredFood = {};
//     for (var spendOn in timeEntries) {
//       previousFilteredFood.add(spendOn['spent_on']);
//     }
//     previousFoodCount.value = previousFilteredFood.length;
//   }
// }
}
