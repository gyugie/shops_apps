import 'package:flutter/widgets.dart';
import '../widgets/cart_item.dart';

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

  void addOrder(List<CartItem> cartProduct, double total){
    OrderItem(
      id: DateTime.now().toString(), 
      amount: total, 
      products: cartProduct, 
      dateTime: DateTime.now()
    );
    
    notifyListeners();
  }


}