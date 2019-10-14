import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screens.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //fetch data from provider
    final product = Provider.of<Product>(context, listen: false);
    final cart    = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName, arguments: product.id
            ); 
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading:Consumer<Product>(
            builder: (ctx, product, child)  =>  IconButton(
              icon:  Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border
              ),
              onPressed: (){
                product.toggleFavoriteStatus();
              },
            ),
          ),
          title: Text(
            product.title, 
            textAlign: TextAlign.center, 
            ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart
              ),
            onPressed: (){
              cart.addItem(product.id, product.price, product.title, product.imageUrl);
            },
          ),
        ),
      ),
    );
  }
}