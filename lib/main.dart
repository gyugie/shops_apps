import 'package:flutter/material.dart';
import './screens/products_overview_screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black54,
        fontFamily: 'Lato',
        textTheme: TextTheme(
          headline: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
          title: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
          body1: TextStyle(
            fontSize: 12,
            fontFamily: 'Hind'
          )
        )
      ),
      home: ProductsOverviewScreens(),
    );
  }
}

