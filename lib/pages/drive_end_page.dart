import 'package:flutter/material.dart';

class DriveEndPage extends StatelessWidget {
  // Replace these with actual values as needed
  final String carNumber = '1234ABC'; // Placeholder for the car number
  final String userName = 'John Doe'; // Placeholder for the user name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drive End'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '$carNumber \n$userName 님 \n수고하셨습니다.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
