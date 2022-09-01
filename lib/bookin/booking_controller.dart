import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lunch_app/setting/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LunchBookingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  initial() async {
    menuApi();
  }

  storedKey() async {
    SharedPreferences appSharedPreference;
    appSharedPreference = await SharedPreferences.getInstance();
    var key = appSharedPreference.getString('userkey');
    return key;
  }

  RxString selectedDropdown = 'Meals with One Chapati'.obs;
  RxList dropdownTextList = [].obs;
  RxList extraDishList = [].obs;
  var dataWithOptionsList;
  findMenu() {
    for (var selected in dropdownTextList) {
      var dishIndex = selected.indexOf(selectedDropdown.value);
      return dishIndex + 1;
    }
  }

  menuApi() async {
    try {
      final response = await http
          .get(Uri.parse(Settings.baseUrl + Settings.menuDisplayUrl), headers: {
        "Content-Type": "application/json",
        "Authorization": "Basic YXBpX3VzZXI6QWNzQDIwMTc=",
      });
      if ((response.statusCode == 200)) {
        var menuResponse = json.decode(response.body);
        var menuContent = menuResponse['custom_fields'];
        Map dataWithOptions = menuContent.firstWhere((item) {
          return item['id'] == 41;
        });
        // print(dataWithOptions);
        dataWithOptionsList = dataWithOptions['possible_values'];
        print(dataWithOptionsList);
        for (var label in dataWithOptionsList) {
          dropdownTextList.add(label['label']);
        }
        Map extraOptions = menuContent.firstWhere((item) {
          return item['id'] == 47;
        });
        var extraOptionsList = extraOptions['possible_values'];
        print(extraOptionsList);
        for (var label in extraOptionsList) {
          extraDishList.add(label['label']);
        }
      }
    } catch (e) {
      throw Exception();
    }
  }

  confirmBookingButton() async {
    var key = await storedKey();
    try {
      final response = await http.post(
          Uri.parse(Settings.baseUrl + Settings.lunchBookingUrl),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Basic $key",
          },
          body: json.encode(bookingData()));
      if ((response.statusCode == 200)) {
        var menuResponse = json.decode(response.body);
        var responseId = menuResponse['id'].toString();
        SharedPreferences appSharedPreference;
        appSharedPreference = await SharedPreferences.getInstance();
        await appSharedPreference.setString('bookedId', responseId);
        // print(responseId);
      }
    } catch (e) {
      throw Exception();
    }
  }

  bookingData() {
    return {
      "time_entry": {
        "project_id": 342,
        "hours": 0,
        "activity_id": 16,
        "custom_fields": [
          {"id": 39, "value": "1"},
          {"id": 41, "value": findMenu().toString()},
          // {"id": 47, "value": specialItemValue},
          {"id": 59, "value": "Non Billable"}
        ],
        "comments": ""
      }
    };
  }
}
