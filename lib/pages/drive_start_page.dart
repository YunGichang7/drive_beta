import 'package:drive_beta/api/bts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:obd2_plugin/obd2_plugin.dart'; // Replace with your actual import path

class DriveStartPage extends GetView<BTSController> {
  const DriveStartPage({super.key, required this.obd2});
  final Obd2Plugin obd2;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('Drive Start Page'),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.refresh),
          //     onPressed: () => initializeObd2(),
          //   ),
          // ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('RPM: ${controller.rpm.value}'),
              SizedBox(height: 20),
              Text('Speed: ${controller.speed.value}'),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
