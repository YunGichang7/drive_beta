import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'main_page.dart';

class ServiceDetailPage extends StatelessWidget {
  final List<String> serviceDetails;

  ServiceDetailPage({required this.serviceDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Details'),
      ),
      body: ListView.builder(
        itemCount: serviceDetails.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(serviceDetails[index]),
            contentPadding: EdgeInsets.all(10),
          );
        },
      ),
    );
  }
}
