import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_app/splash/splash.controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({Key? key}) : super(key: key) {
    controller.initial();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 102, 202, 241),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: Center(
          child: Image.network(
        'https://cdn.pixabay.com/photo/2016/05/26/14/11/chef-1417239__340.png',
        width: 250,
        height: 250,
      )),
    );
  }
}
