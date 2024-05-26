import 'package:drive_beta/api/bts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

Future<bool?> showBluetoothDevice(BuildContext context) async {
  return await showModalBottomSheet(
      context: context,
      builder: (builder) {
        return const BTSBottomSheet();
      });
}

class BTSBottomSheet extends StatefulWidget {
  const BTSBottomSheet({super.key});

  @override
  State<BTSBottomSheet> createState() => _BTSBottomSheetState();
}

class _BTSBottomSheetState extends State<BTSBottomSheet> {
  final FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  List<BluetoothDevice> discoveryDevices = [];
  bool isScanning = true;
  BluetoothDevice? tryConnecting;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bluetooth.startDiscovery().listen(
      (event) {
        final existingIndex = discoveryDevices
            .indexWhere((element) => element.address == event.device.address);
        if (existingIndex >= 0) {
          discoveryDevices[existingIndex] = event.device;
        } else {
          if (event.device.name != null) {
            setState(() {
              discoveryDevices.add(event.device);
            });
          }
        }
      },
      onDone: () => setState(() {
        isScanning = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0),
      width: double.infinity,
      height: 400,
      child: ListView.separated(
        itemCount:
            isScanning ? discoveryDevices.length + 1 : discoveryDevices.length,
        itemBuilder: (context, index) {
          return isScanning && index == discoveryDevices.length
              ? const Center(
                  child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ))
              : ListTile(
            title: Text(discoveryDevices[index].name.toString()),
            trailing: tryConnecting == discoveryDevices[index]?const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator()):null,
            onTap: () {
              if (tryConnecting != null) {
                return;
              }
              setState(() {
                tryConnecting = discoveryDevices[index];
              });
              BTSController.to
                  .connectToDevice(discoveryDevices[index].address)
                  .then((value) {
                if (value) {
                  Navigator.of(context).pop(value);
                } else {
                  setState(() {
                    tryConnecting = null;
                  });
                }
              });
            },
          );
        },
        separatorBuilder: (context, index) =>
            isScanning && index == discoveryDevices.length
                ? const SizedBox()
                : const Divider(),
      ),
    );
  }
}
