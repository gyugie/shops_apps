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

  final authToken;
  Orders(this.authToken, this._orders);

  Future<void> fetchAndSetOrders() async {
    final url                           = 'https://flutter-update-32aaf.firebaseio.com/orders.json?auth=$authToken';
    final response                      = await http.get(url);
    final List<OrderItem> loadedOrders  = [];
    final extractData                   = json.decode(response.body) as Map<String, dynamic>;

    if(extractData == null){
      return;
    }

    extractData.forEach((orderId, orderData){
      loadedOrders.add(OrderItem(
        id: orderId,
        amount: orderData['amount'],
        dateTime: DateTime.parse(orderData['dateTime']),
        products: (orderData['products'] as List<dynamic>).map((order) => 
          CartItem(
            id: order['id'],
            title: order['title'],
            imageUrl: order['imageUrl'],
            quantity: order['quantity'],
            price: order['price']
          ),
        ).toList(),
      )
    );
  });

  _orders = loadedOrders.reversed.toList();
  notifyListeners();
    
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    final url         = 'https://flutter-update-32aaf.firebaseio.com/orders.json?auth=$authToken';
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