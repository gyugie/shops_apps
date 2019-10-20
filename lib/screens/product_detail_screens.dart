import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId     = ModalRoute.of(context).settings.arguments as String; // for get arguments in another screen
    final loadedProduct = Provider.of<Products>(context, listen: false).findById(productId); // finding data by id
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true, 
      //   title: Text(
      //     loadedProduct.title, 
      //     style: Theme.of(context).textTheme.title,
      //     textAlign: TextAlign.center,
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   iconTheme: IconThemeData(
      //     color: Colors.black
      //   ),
      // leading: new IconButton(
      //     icon: Icon(
      //       Icons.chevron_left,
      //       color: Colors.black,
      //       size: 35,
      //     ),
      //     onPressed: () { Navigator.of(context).pop(); },
      //   ),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                loadedProduct.title, 
                // style: Theme.of(context).textTheme.title,
              ),
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10),
              Container(
                child: Text(
                  '\$ ${loadedProduct.price}', 
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                    ),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${loadedProduct.description}', 
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).accentColor,
                    ),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 800)
            ]),
          ),
        ],
      ),
    );
  }
}