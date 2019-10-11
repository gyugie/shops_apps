import 'package:flutter/material.dart';
import '../widgets/product_grid.dart';

enum FilterOptions {
  Favorites,
  All
}

class ProductOverviewScreens extends StatefulWidget {
  @override
  _ProductOverviewScreensState createState() => _ProductOverviewScreensState();
}

class _ProductOverviewScreensState extends State<ProductOverviewScreens> {
  bool _isFavoritesItems = false;

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
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue){
              
              setState(() {
                if(selectedValue == FilterOptions.Favorites){
                  _isFavoritesItems = true;
                } else {
                  _isFavoritesItems = false;
                }
              });
              
            },
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Only Favorite'), value: FilterOptions.Favorites),
              PopupMenuItem(child: Text('Show All'), value: FilterOptions.All),
            ],
          )
        ],
      ),
      body: ProductsGrid(_isFavoritesItems),
    );
  }
}

