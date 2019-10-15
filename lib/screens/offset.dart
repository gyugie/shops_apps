import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  static const routeName = '/card';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(),
  body: ListView(
    children: <Widget>[
      blockCard(),
      blockCard(),
      blockCard(),
    ],
  ),
);

    }
    Widget blockCard(){
      return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        child: new Stack(
          children: <Widget>[
            Card(
              child: Container(
                height: 100.0,
              ),
              elevation: 3,
            ),
            FractionalTranslation(
              translation: Offset(0.0, -0.5),
              child: Align(
                child: CircleAvatar(
                  radius: 25.0,
                  child: Text("A"),
                ),
                alignment: FractionalOffset(0.8, 0.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}