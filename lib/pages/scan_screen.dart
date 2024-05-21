import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'drive_start_page.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus();
  late StreamSubscription<List<ScanResult>> scanSubscription;
  List<ScanResult> scanResults = [];
  bool isScanning = false;

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
      appBar: AppBar(
        title: Text('Bluetooth Scan'),
      ),
      body: ListView.builder(
        itemCount: scanResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(scanResults[index].device.name.isEmpty ? 'Unknown Device' : scanResults[index].device.name),
            subtitle: Text(scanResults[index].device.id.toString()),
            trailing: ElevatedButton(
              child: Text('Connect'),
              onPressed: () => connectToDevice(scanResults[index].device),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isScanning ? stopScan : startScan,
        child: Icon(isScanning ? Icons.stop : Icons.search),
        backgroundColor: isScanning ? Colors.red : Colors.green,
      ),
    );
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      print('Connected to ${device.name}');
      Navigator.pushNamed(context, '/drive_start_page');
    } catch (e) {
      print('Error connecting to device: $e');
    }
  }
}
