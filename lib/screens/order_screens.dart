import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';


class OrderScreens extends StatefulWidget {
  static const routeName = '/order-screen';

  @override
  _OrderScreensState createState() => _OrderScreensState();
}

class _OrderScreensState extends State<OrderScreens> {
  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then( (_) async {
      setState(() {
        _isLoading = true;
      });

      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      
      setState(() {
        _isLoading = false;
      });
    });

   
    

    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    print(_isLoading);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: AppDrawer(),
      body: _isLoading 
      ? 
      Center( child: CircularProgressIndicator())
      :
      ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, index) => OrderItem(orderData.orders[index]),
      ),
    );
  }
}