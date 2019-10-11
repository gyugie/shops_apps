import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

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
                    onPressed: () {},
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),

                ],
              ),
            ),

          )
        ],
      ),
    );
  }
}