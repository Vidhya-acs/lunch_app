// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:lunch_app/fetch/fetch_controller.dart';

// void main() {
//   runApp(GetMaterialApp(
//     home: FetchView(),
//   ));
// }

// class FetchView extends GetView<FetchController> {
//   FetchView({Key? key}) : super(key: key);
//   final controller = Get.put(FetchController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: controller.obx((data) => ListView.builder(
//             itemCount: data.length,
//             itemBuilder: (context, index) {
//               var payable = data['total_count'];
//               return Column(
//                 children: [Text('${payable}')],
//               );
//             })));
//   }
// }
