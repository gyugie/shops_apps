import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/product_item.dart';


class ProductsGrid extends StatelessWidget {
  final bool isFavs;

  ProductsGrid(this.isFavs);

  @override
  Widget build(BuildContext context) {
   final productsData  = Provider.of<Products>(context);
   final products      = isFavs ? productsData.favoritItems : productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          // builder: (c) => products[index],
          value: products[index],
          child: ProductItem(),
        ),// data aleady fetch from provider
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20
        ),
      );
  }
}
