import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int quantity;
  final double price;
  
  CartItem(this.id, this.title, this.imageUrl, this.quantity, this.price);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Image.network(imageUrl),
            )
          ),
          title: Text(title),
          subtitle: Text('Sub Total ${price * quantity}'),
          trailing: Text('${quantity} pcs'),
        ),
      ),
    );
  }
}