import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_apps/providers/orders.dart' as prefix0;
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';


class OrderScreens extends StatelessWidget {
  static const routeName = '/order-screen';
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder( 
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot){
        
          if(dataSnapshot.connectionState == ConnectionState.waiting){
            return Center(
                child: CircularProgressIndicator(),
              );
          } else {
            if(dataSnapshot.error != null){
              return Center(
                child: Text('An error ocurred!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                      itemCount: orderData.orders.length,
                      itemBuilder: (ctx, index) => OrderItem(orderData.orders[index]),
                    ),
              );
            }
          }
        },
      ),
    );
  }
}