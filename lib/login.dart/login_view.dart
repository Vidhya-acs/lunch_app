import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lunch_app/app_paths/app_path.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  final formKey = GlobalKey<FormState>();
  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.10,
            right: MediaQuery.of(context).size.width * 0.10,
            // top: MediaQuery.of(context).size.width * 0.40
            bottom: 50),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _agilexIcon(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.050,
              ),
              userName(),
              _password(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.050,
              ),
              _loginButton()
            ],
          ),
        ),
      ),
    );
  }

  _agilexIcon() {
    return SvgPicture.network(
      'https://www.agilecyber.com/wp-content/themes/agilex/assets/images/logo_icon.svg',
      width: 60,
      height: 60,
    );
  }

  userName() {
    return TextFormField(
      controller: controller.userNameController,
      decoration: const InputDecoration(
          labelText: 'User Name',
          prefixIcon: Icon(
            Icons.person,
            color: Colors.blue,
          )),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
      onSaved: ((value) => formKey.currentState!.save()),
    );
  }

  _password() {
    return TextFormField(
        controller: controller.passwordController,
        obscureText: controller.isPasswordHidden.value,
        decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.blue,
            ),
            suffix: (controller.isPasswordHidden.value)
                ? IconButton(
                    onPressed: () {
                      controller.isPasswordVisibile();
                    },
                    icon: Icon(Icons.visibility_off))
                : IconButton(
                    onPressed: () {
                      controller.isPasswordVisibile();
                    },
                    icon: Icon(Icons.visibility))),
        onSaved: ((value) => formKey.currentState!.save()),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          if (value.trim().length < 8) {
            return 'Password must be at least 8 characters in length';
          }

          return null;
        });
  }

  _loginButton() {
    return Row(children: [
      Expanded(
          child: ElevatedButton(
              onPressed: () {
                _trySubmitForm();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                minimumSize: Size(0, 50),
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 20),
              ))),
    ]);
  }

  void _trySubmitForm() {
    final bool? isValid = formKey.currentState?.validate();
    if (isValid == true) {
      var username = controller.userNameController.text.trim();
      var password = controller.passwordController.text;
      var loginKey = controller.getKey(username, password);
      controller.apiCall(loginKey, username);
    }
  }
}
