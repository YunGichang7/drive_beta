import 'package:drive_beta/api/bts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drive_beta/pages/login_page.dart';

import 'pages/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => BTSController());
      }),
      home: MainPage(),
      // home: LoginPage(),
    );
  }
}
