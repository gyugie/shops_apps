import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text('Is Loading...', style: TextStyle(fontSize: 20),),
        ),
    );
  }
}