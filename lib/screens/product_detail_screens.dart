import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    print(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text('title', style: Theme.of(context).textTheme.title,
        ),
      ),
    );
  }
}