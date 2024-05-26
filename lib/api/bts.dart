import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

class BTSController extends GetxController{

  static BTSController get to => Get.find<BTSController>();
  Rx<BluetoothConnection?> connection = Rx<BluetoothConnection?>(null);
  RxBool isConnecting = true.obs;
  RxBool isConnected = false.obs;

  RxString rpm = ''.obs;
  RxString speed = ''.obs;

  Timer? autosync;




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    connection.value?.dispose();
    autosync?.cancel();
    super.dispose();
  }

  void requestData()async{
    print('requestData');
    sendData('01 0C\r');
    await Future.delayed(const Duration(milliseconds: 200));
    sendData('01 0D\r');
  }

  void processReceivedData(String data) {
    List<String> lines = data.split('\r');
    for (String line in lines) {
      if (line.contains(' 41 0C ')) {
        print('Data received: $data');
        String rpmData = line.split(' ')[4] + line.split(' ')[5];
        int rpmValue = int.parse(rpmData, radix: 16);
        rpmValue = rpmValue ~/ 4;
        rpm(rpmValue.toString());
      } else if (line.contains(' 41 0D ')) {
        print('Data received: $data');
        String speedData = line.split(' ')[4];
        int speedValue = int.parse(speedData, radix: 16);
        speed(speedValue.toString());
      }
    }
  }

  Future sendData(String data) async {
    if (isConnected.value && connection.value != null) {
      connection.value?.output.add(Uint8List.fromList(data.codeUnits));
      await connection.value?.output.allSent;
    }
  }

  Future<bool> connectToDevice(String deviceAddress)async{
    try {
      connection.value = await BluetoothConnection.toAddress(deviceAddress);
      isConnecting(false);
      isConnected(true);
      print('Connected to the device');

      connection.value?.input?.listen((Uint8List data) {
        String response = ascii.decode(data);
        processReceivedData(response);
      }).onDone(() {
        print('Disconnected by remote request');
        isConnected(false);
      });

      sendData('ATZ\r');
      await Future.delayed(const Duration(seconds: 2));
      sendData('ATE0\r');
      await Future.delayed(const Duration(milliseconds: 200));
      sendData('ATL0\r');
      await Future.delayed(const Duration(milliseconds: 200));
      sendData('ATH1\r');
      await Future.delayed(const Duration(milliseconds: 200));
      sendData('ATS1\r');
      await Future.delayed(const Duration(milliseconds: 200));
      sendData('ATSP6\r');

      await Future.delayed(const Duration(seconds: 2));

      autosync = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (isConnected.value) {
          requestData();
        } else {
          timer.cancel();
        }
      });
      return true;
    } catch (e,s) {
      print('Cannot connect, exception occurred');
      print(e);
      connection.value?.dispose();
      connection(null);
      isConnecting(false);
      isConnected(false);
      return false;
    }
  }
}