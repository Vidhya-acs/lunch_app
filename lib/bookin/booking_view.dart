import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lunch_app/app_paths/app_path.dart';
import 'package:lunch_app/constant/app_variables.dart';
import 'booking_controller.dart';

class LunchBookingView extends GetView<LunchBookingController> {
  LunchBookingView({Key? key}) : super(key: key) {
    controller.initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppVariables.lunchBookingAppBarTitle),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30, right: 20, bottom: 20, left: 20),
        //color: Colors.blue,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppVariables.dropDownTitle,
                    style: const TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => DropdownButtonFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.blue))),
                      value: controller.selectedDropdown.value,
                      items: [
                        for (var data in controller.dropdownTextList.value)
                          DropdownMenuItem(
                            value: data,
                            child: Text(
                              data.toString(),
                            ),
                          )
                      ],
                      // controller.dropdownTextList.map(buildMenuItem).toList(),
                      onChanged: (value) =>
                          controller.selectedDropdown.value = value as String)),
                  const SizedBox(
                    height: 30,
                  ),
                  _optionDish(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: _listViewBuilderForExtras(),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [_bookLunchButton()],
            )
          ],
        ),
      ),
    );
  }

  _listViewBuilderForExtras() {
    return ListView.builder(
        itemCount: controller.extraDishList.length,
        itemBuilder: ((context, index) {
          return ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.grey,
              // minimumSize: Size(300, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Obx(() => Text(controller.extraDishList[index])),
          );
        }));
  }

  _optionDish() {
    return Text(
      AppVariables.optionalDish,
      style: TextStyle(fontSize: 15, color: Colors.blue),
    );
  }

  _bookLunchButton() {
    return ElevatedButton.icon(
      onPressed: () {
        controller.confirmBookingButton();
        Get.toNamed(AppPath.viewOder,
            arguments: {"selectedDishName": controller.selectedDropdown.value});
      },
      icon: Icon(Icons.fastfood),
      label: Text(AppVariables.bookLunch),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }
}
