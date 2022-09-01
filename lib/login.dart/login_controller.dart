import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_app/app_paths/app_path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_view.dart';

class LoginController extends GetxController {
  var isPasswordHidden = true.obs;
  isPasswordVisibile() {
    isPasswordHidden.toggle();
  }

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  apiCall(loginKey, username) async {
    try {
      final response = await http.get(
          Uri.parse('https://pm.agilecyber.co.uk/users/current.json'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Basic $loginKey",
          });
      if ((response.statusCode == 200) && !(response.body.isEmpty)) {
        var loginApiBody = json.decode(response.body);
        var loginUserName = loginApiBody['user']['firstname'];
        SharedPreferences appSharedPreference;
        appSharedPreference = await SharedPreferences.getInstance();
        await appSharedPreference.setString('userkey', loginKey);
        await appSharedPreference.setString('username', loginUserName);
        Get.offNamed(
          AppPath.home,
        );
      } else {
        return Get.dialog(AlertDialog(
          title: Text('User not found'),
          content: Text('Please register,if not registered yet'),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('OK'))
          ],
        ));
      }
    } catch (e) {
      return Get.dialog(AlertDialog(
        title: Text('Some error'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('${e}'))
        ],
      ));
    }
  }

  getKey(username, password) {
    var key = base64.encode(utf8.encode(username + ":" + password));
    return key;
  }
}
