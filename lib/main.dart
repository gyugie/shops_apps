import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/cart_screens.dart';
import './screens/product_detail_screens.dart';
import './screens/products_overview_screens.dart';
import './providers/auth.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/order_screens.dart';
import './screens/user_product_screens.dart';
import './screens/edit_product_screens.dart';
import './screens/offset.dart';
import './screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          builder: (ctx, auth, previousProduct) => Products(
            auth.token,
            auth.userId,
            previousProduct == null ? [] : previousProduct.items
           ), initialBuilder: (BuildContext context) {}, 
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          builder: (ctx, authData, previousOrders) => Orders(
            authData.token, 
            previousOrders == null ? [] : previousOrders.orders), 
          initialBuilder: (BuildContext context) {},
        ),
      ],
      child: Consumer<Auth>(builder: (ctx, authData, child) => MaterialApp(
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
        home: authData.isAuth ? ProductOverviewScreens() : AuthScreen(),
        routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreens.routeName: (ctx) => CartScreens(),
            OrderScreens.routeName: (ctx) => OrderScreens(),
            UserProductScreens.routeName: (ctx) => UserProductScreens(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            CustomCard.routeName: (ctx) => CustomCard()
          },
        ),
      ) 
    );
  }
}

