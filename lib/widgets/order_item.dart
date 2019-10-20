import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer( 
      duration: Duration(milliseconds: 500),
      height: _expanded ? min(widget.order.products.length * 20.0 + 110, 200) : 90 ,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$ ${widget.order.amount}'),
            subtitle: Text(DateFormat('dd MM yyyy hh:mm').format(widget.order.dateTime)
            ),
            trailing: IconButton(
              icon: Icon( _expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: _expanded ? min(widget.order.products.length * 20.0 + 10, 200) : 0,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5
            ),
            child: ListView(
              children: widget.order.products
                .map( 
                  (prod) => Row(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          prod.title, 
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                        ),
                        Text(
                          '${prod.quantity} x \$${prod.price}', 
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}