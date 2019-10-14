import 'package:flutter/material.dart';
import '../screens/user_product_screens.dart';
import '../screens/order_screens.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Payment Here!'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrderScreens.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.image),
            title: Text('Manage Product'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(UserProductScreens.routeName);
            },
          ),
        ],
      ),
    );
  }
}