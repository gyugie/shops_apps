import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';


class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final String imageUrl;
  final int quantity;
  final double price;
  
  CartItem(this.id, this.productId, this.title, this.imageUrl, this.quantity, this.price);
  
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.black,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4
          ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            elevation: 4,
            title: Text('Are you sure!'),
            content: Text('Do you want to remove the item from cart ?'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes', style: TextStyle( color: Colors.red)),
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          )
        );
      },
      onDismissed: (direction){
        Provider.of<Cart>(context, listen: false).removeCart(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
            ),
            title: Text(title),
            subtitle: Text('Sub Total ${price * quantity}'),
            trailing: Text('${quantity} pcs'),
          ),
        ),
       ),
    );
  }
}