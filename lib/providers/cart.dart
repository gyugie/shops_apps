// import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final String imageUrl;
  final int quantity;
  final double price;

  CartItem({this.id, this.title, this.imageUrl, this.quantity, this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items{
    return {..._items};
  }

  int get itemCount{
    return _items.length;
  }

  double get totalAmount{
    var total = 0.0;
    _items.forEach( (key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void addItem(String productId, double price, String title, String imageUrl){
    if( _items.containsKey(productId) ){
      //change quantity
      _items.update(
        productId, 
        (existingCartItem) => CartItem(
                              id: existingCartItem.id,
                              title: existingCartItem.title,
                              imageUrl: existingCartItem.imageUrl,
                              price: existingCartItem.price,
                              quantity: existingCartItem.quantity + 1
                            )
        );

    } else {
      _items.putIfAbsent(
        productId, 
        () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                imageUrl: imageUrl,
                price: price,
                quantity: 1
              ),
      );
      notifyListeners();
    }
  }

  void removeCart(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  void clear(){
    _items = {};
    notifyListeners();
  }
}