import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './cart.dart';

class OrderItem{
  final String id;
  final double amount; 
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime
  });

}

class Orders with ChangeNotifier{
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProduct, double total) async {
    final url         = 'https://flutter-update-32aaf.firebaseio.com/orders.json';
    final timestamp   = DateTime.now();
    // store order to database
     final response = await http.post(url, body: json.encode({
        'amount'    : total,
        'dateTime'  : timestamp.toIso8601String(),
        'products'  : cartProduct.map( (cart) => {
            'id'      : cart.id,
            'title'   : cart.title,
            'quantity': cart.quantity,
            'price'   : cart.price,
            'imageUrl': cart.imageUrl
          }).toList()
        })
      );

      //store data for local
      _orders.insert(
        0,
      OrderItem(
        id: json.decode(response.body)['name'], 
        amount: total, 
        products: cartProduct, 
        dateTime: timestamp
      ),
      );

    notifyListeners();
  }


}