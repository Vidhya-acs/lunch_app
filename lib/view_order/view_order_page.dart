import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_app/constant/app_variables.dart';
import 'package:lunch_app/view_order/view_order_controller.dart';

class ViewOrder extends GetView<ViewOrderController> {
  ViewOrder({Key? key}) : super(key: key) {
    controller.initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppVariables.lunchBookingAppBarTitle),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  // _alertBox(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _cancelBookingButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  _alertBox() {
    return Get.defaultDialog(
        title: AppVariables.lunchConformAlertTitle,
        content: Column(
          children: [
            Text(AppVariables.lunchConformAlertBody),
            ListTile(
              leading: const Icon(
                Icons.check,
                color: Colors.green,
              ),
              title: Text('${Get.arguments['selectedDishName']}'),
            )
          ],
        ));
  }

  _cancelBookingButton() {
    return ElevatedButton.icon(
      onPressed: () {
        controller.cancelApi();
        cancelConfirmSnackBar();
      },
      icon: Icon(Icons.fastfood),
      label: Text(AppVariables.cancelLunch),
      style: ElevatedButton.styleFrom(
        primary: Colors.amber[900],
        minimumSize: Size(0, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }

  cancelConfirmSnackBar() {
    return Get.snackbar(
        AppVariables.BookingCancelTitle, AppVariables.BookingCancelMessage);
  }
}
