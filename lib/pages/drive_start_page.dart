import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:obd2_plugin/obd2_plugin.dart'; // Replace with your actual import path

class DriveStartPage extends StatefulWidget {
  final BluetoothDevice device;

  DriveStartPage({required this.device});

  @override
  _DriveStartPageState createState() => _DriveStartPageState();
}

class _DriveStartPageState extends State<DriveStartPage> {
  final Obd2Plugin obd2 = Obd2Plugin();
  String dataReceived = "Awaiting data...";

  @override
  void initState() {
    super.initState();
    initializeObd2();
  }

  void initializeObd2() async {
    bool enabled = await obd2.enableBluetooth;
    if (enabled) {
      await obd2.configObdWithJSON(configJson);
      obd2.setOnDataReceived((command, response, requestCode) {
        setState(() {
          dataReceived = "$command => $response";
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drive Start Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => initializeObd2(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(dataReceived, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  String get configJson => '''
    [
      {
        "command": "AT Z",
        "status": true
      },
      {
        "command": "AT E0",
        "status": true
      },
      {
        "command": "01 0C", // RPM
        "status": true
      },
      {
        "command": "01 0D", // Speed
        "status": true
      }
    ]
  ''';
}
