import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:todolistapp/login.dart';

import '../model/model.dart';

class Service {
  static Future<Map<String, dynamic>> getDataHome() async {
    Dio dio = Dio();
    var response = await dio.get('http://10.0.2.2:3000/data');
    print('status code : ${response.statusCode}');
    var dataResponse = response.data;

    return dataResponse;
  }
//   static Future<List> getDataHome() async {
//     Dio dio = Dio();
//     var response = await dio.get('http://10.0.2.2:3000/data');
//     List<dynamic> data =
//         (response.data['data'] as List).map((v) => Data.fromJson(v)).toList();

//     // Ramene.fromJson(response.data['data'])
//     return data;
//   }
}
// void register(String nama, email, password, BuildContext context) async {
//   try {
//     var response = await Dio().post('http://10.0.2.2:3000/user',
//         data: {"nama": nama, "email": email, "password": password});
//     if (response.statusCode == 201) {
//       print("Account created successfully");
//       AlertDialog alert = AlertDialog(
//         title: Text("Registrasi Berhasil"),
//         content: Container(
//           child: Text("Selamat Anda Berhasil Registrasi akun"),
//         ),
//         actions: [
//           TextButton(
//             child: Text("OK"),
//             onPressed: () => Navigator.push(context,  MaterialPageRoute(
//                     builder: (context) =>
//                         LoginPage(setTheme: widget.setTheme))),
//             // Navigator.push(
//             //     context,
//             //     MaterialPageRoute(
//             //         builder: (context) =>
//             //             landingPage(setTheme: widget.setTheme)));
//           ),
//         ],
//       );

//       showDialog(context: context, builder: (context) => alert);
//       return;
//     } else {
//       print("Failed");
//     }
//   } catch (e) {
//     print(e);
//   }
// }
