import 'package:flutter/material.dart';
import '../widgets/product_grid.dart';

class ProductsOverviewScreens extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, 
        title: Text('MyShop',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.title,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: ProductsGrid(),
    );
  }
}

