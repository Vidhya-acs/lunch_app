import 'package:flutter/material.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:get/get.dart';
import 'package:lunch_app/app_paths/app_path.dart';
import 'package:lunch_app/constant/app_variables.dart';
import 'package:lunch_app/home/home_controller.dart';
import 'home_controller.dart';

void main() {
  runApp(
    GetMaterialApp(home: HomeView()),
  );
}

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key) {
    controller.initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Icon(Icons.home),
            title: Obx(
              () => Text(
                'Welcome ${controller.loggedUserName.value}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )),
        body: DoubleBack(
          onFirstBackPress: (context) {
            const snackBar =
                SnackBar(content: Text('Press back again to exit'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.004,
                right: MediaQuery.of(context).size.height * 0.004,
                left: MediaQuery.of(context).size.height * 0.004,
                bottom: MediaQuery.of(context).size.height * 0.015),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      // SnackBar(content: Text('Press again to exit')),
                      _previousMonthBooking(context),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      _currentMonthBokking(context),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _lunchBookingButton(),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  _currentMonthBokking(context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // color: Colors.amber,
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Text(
                    controller.currentMonthName.value,
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppVariables.bookingCount,
                      style: TextStyle(color: Colors.blue)),
                  Obx(() => Text(controller.currentFoodCount.value.toString()))
                ],
              )),
              SizedBox(width: MediaQuery.of(context).size.width * 0.04),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(AppVariables.payableCount,
                        style: TextStyle(color: Colors.blue)),
                    Obx(() => Text(controller.curentPayable.value.toString()))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _previousMonthBooking(context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // color: Colors.amber,
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Text(
                    controller.previousMonthName.value,
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppVariables.bookingCount,
                      style: TextStyle(color: Colors.blue)),
                  Obx(() => Text(controller.previousFoodCount.value.toString()))
                ],
              )),
              SizedBox(width: MediaQuery.of(context).size.width * 0.04),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(AppVariables.payableCount,
                        style: TextStyle(color: Colors.blue)),
                    Obx(() =>
                        Text(controller.previousFoodPayable.value.toString()))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _lunchBookingButton() {
    return ElevatedButton.icon(
      onPressed: () {
        controller.currentMonthbookedLunch();
        Get.toNamed(AppPath.booking);
        // controller.timeChecking();
      },
      icon: Icon(Icons.fastfood),
      label: Text(AppVariables.lunchBookingButton),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }
}
