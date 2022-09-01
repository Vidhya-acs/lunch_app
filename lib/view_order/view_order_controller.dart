import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:lunch_app/setting/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewOrderController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  initial() {
    cancelApi();
  }

  storedKey() async {
    SharedPreferences appSharedPreference;
    appSharedPreference = await SharedPreferences.getInstance();
    var key = appSharedPreference.getString('bookedId');
    return key;
  }

  getCancelKey() async {
    var cancelId = await storedKey();
    var cancelKey = base64.encode(utf8.encode(cancelId));

    return cancelKey;
  }

  cancelApi() async {
    var key = await storedKey();
    try {
      final response = await http.delete(
        Uri.parse(Settings.baseUrl +
            Settings.lunchCancellingUrl +
            getCancelKey().toString()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic $key",
        },
      );
      if ((response.statusCode == 204)) {
        var menuResponse = json.decode(response.body);
      }
    } catch (e) {
      throw Exception();
    }
  }
}
