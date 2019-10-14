import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/cart_screens.dart';
import './screens/product_detail_screens.dart';
import './screens/products_overview_screens.dart';
import './providers/products.dart';
import './providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
              color: Colors.black
            ),
            body1: TextStyle(
              fontSize: 12,
              fontFamily: 'Hind'
            )
          )
        ),
        home: ProductOverviewScreens(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreens.routeName: (ctx) => CartScreens(),
          },
        ),
    );
  }
}

