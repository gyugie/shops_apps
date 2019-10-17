import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_product_screens.dart';

import '../widgets/app_drawer.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';

class UserProductScreens extends StatefulWidget {
  static const routeName = '/user-product';

  @override
  _UserProductScreensState createState() => _UserProductScreensState();
}

class _UserProductScreensState extends State<UserProductScreens> {
  var _isLoading = true;

  @override
  void initState(){
    _refreshProduct(context);
    setState(() {
      _isLoading = false;
    });
    super.initState();
  }

  Future<void> _refreshProduct(context) async {
     
    return await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Product'),
        iconTheme: IconThemeData(color: Colors.white), 
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      )
      :
       RefreshIndicator(
          onRefresh: () => _refreshProduct(context),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (ctx, index) => UserProductItem(
              productData.items[index].id, 
              productData.items[index].title, 
              productData.items[index].imageUrl
            ),
          ),
        )
      ),
    );
  }
}