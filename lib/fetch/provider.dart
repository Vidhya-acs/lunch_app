// // // final response= get('https://pm.agilecyber.co.uk/time_entries.json');
// // import 'dart:convert';
// //base url=https://pm.agilecyber.co.uk;
// import 'dart:convert';

// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class Provider extends GetConnect {
//   //FetchModel? dataOfUserFromApi;
//   RxBool isDataLoading = true.obs;

//   Future<Map<String, dynamic>> fetchUser() async {
//     final response = await http.get(Uri.parse(
//         'https://pm.agilecyber.co.uk/time_entries.json?project_id=342&limit=100&spent_on='));
//     if (response.statusCode == 200) {
//       final decodedValue = jsonDecode(response.body);
//       return decodedValue;
//     } else {
//       throw Future.error(response.toString());
//     }
//   }
// }
//  try {
//       isDataLoading(true);
//       final response = await http.get(Uri.parse(
//           'https://pm.agilecyber.co.uk/time_entries.json?project_id=342&limit=100&spent_on='));

//       if (response.statusCode == 200) {
//         return dataOfUserFromApi =
//             FetchModel.fromJson(jsonDecode(response.body));
//       } else {
//         throw Exception('Failed to load');
//       }
//     } catch (e) {
//       throw AlertDialog(
//         title: Text('error ${e}'),
//       );
//     } finally {
//       isDataLoading(false);
//     }