import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../screens/cart_screens.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../providers/products.dart';


enum FilterOptions {
  Favorites,
  All
}

class ProductOverviewScreens extends StatefulWidget {
  @override
  _ProductOverviewScreensState createState() => _ProductOverviewScreensState();
}

class _ProductOverviewScreensState extends State<ProductOverviewScreens> {
  bool _isFavoritesItems  = false;
  var _isInit             = true;
  var _isLoading          = false;

  @override
  void didChangeDependencies() {
    if(_isInit){
      _isLoading = true;
      Provider.of<Products>(context).fetchAndSetProducts().then( (_){
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, 
        title: Text('MyShops',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.title,
          ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black), 
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
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
                    child: ch,
                    value: cart.itemCount.toString(),
                  ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreens.routeName);
                },
              ), 
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      )
      :
      ProductsGrid(_isFavoritesItems)
    );
  }
}

