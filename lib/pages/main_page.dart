import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'drive_start_page.dart';
import 'tutorial.dart';
import 'login_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus();
  late StreamSubscription<List<ScanResult>> scanSubscription;
  List<ScanResult> scanResults = [];
  bool isScanning = false;
  Map<String, String> connectButtonText = {};

  @override
  void initState() {
    super.initState();
    // Subscribe to scan results
    scanSubscription = FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        scanResults = results;
      });
    });

    // Subscribe to scanning state
    FlutterBluePlus.isScanning.listen((isCurrentlyScanning) {
      setState(() {
        isScanning = isCurrentlyScanning;
      });
    });
  }

  @override
  void dispose() {
    scanSubscription.cancel();
    super.dispose();
  }

  void startScan() async {
    await FlutterBluePlus.startScan(timeout: Duration(seconds: 30));
  }

  void stopScan() async {
    await FlutterBluePlus.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (!isScanning) {
              startScan();
              showScanResultsDialog(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          ),
          child: Text('Start Driving', style: TextStyle(fontSize: 20)),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          margin: EdgeInsets.all(10),
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TutorialPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            child: Text('How to Use'),
          ),
        ),
      ),
    );
  }

  void showScanResultsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(isScanning ? '스캔 진행중...' : '스캔 결과'),
            content: Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: scanResults.length,
                itemBuilder: (BuildContext context, int index) {
                  final device = scanResults[index].device;
                  final deviceId = device.id.toString();
                  return ListTile(
                    title: Text(device.name.isEmpty ? 'Unknown Device' : device.name),
                    subtitle: Text(deviceId),
                    trailing: ElevatedButton(
                      onPressed: () => connectToDevice(device),
                      child: Text(connectButtonText[deviceId] ?? 'Connect'),
                    ),
                  );
                },
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  stopScan();
                },
                child: Text('Close'),
              ),
            ],
          );
        }
    ).then((_) => stopScan()); // Ensure scan stops when dialog is dismissed in any way
  }

  void connectToDevice(BluetoothDevice device) async {
    setState(() {
      connectButtonText[device.id.toString()] = 'Connecting...';
    });

    try {
      await device.connect();
      print('Connected to ${device.name}');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DriveStartPage(device: device)),
      );
    } catch (e) {
      setState(() {
        connectButtonText[device.id.toString()] = 'Connect';
      });
      print('Error connecting to device: $e');
    }
  }
}
