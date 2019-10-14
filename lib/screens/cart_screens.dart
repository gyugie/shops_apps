import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';


class CartScreens extends StatelessWidget {
  static const routeName = '/cart-screens';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Youre Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child:Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total', style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Chip(
                    label: Text('\$ ${cart.totalAmount}'),
                  ),
                  FlatButton(
                    child: Text('Order Now'),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount
                      );
                      cart.clear();
                    },
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                 
                ],
              ),
            ),
          ),
           SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (ctx, index) => CartItem(
                        cart.items.values.toList()[index].id,
                        cart.items.keys.toList()[index],
                        cart.items.values.toList()[index].title,
                        cart.items.values.toList()[index].imageUrl,
                        cart.items.values.toList()[index].quantity,
                        cart.items.values.toList()[index].price,
                      ),
                  ),
                ),
        ],
      ),
    );
  }
}