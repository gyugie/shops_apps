import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreens extends StatefulWidget {
  static const routeName = '/cart-screens';

  @override
  _CartScreensState createState() => _CartScreensState();
}

class _CartScreensState extends State<CartScreens> {

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

                  OrderButton(cart:cart),
                 
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

class OrderButton extends StatefulWidget {
    const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key : key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator(backgroundColor: Colors.white) : Text('Order Now'),
      onPressed: widget.cart.totalAmount <= 0 ? null : () async {
        setState(() {
          _isLoading = true;
        });

        await Provider.of<Orders>(context, listen: false).addOrder(
          widget.cart.items.values.toList(),
          widget.cart.totalAmount
        );
        
        widget.cart.clear();
        
        setState(() {
          _isLoading = false;
        });
      },
      textColor: Colors.white,
      color: Theme.of(context).primaryColor,
    );
  }
}