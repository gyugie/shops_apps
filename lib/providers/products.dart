import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

import './product.dart';

class Products with ChangeNotifier{
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  var showFavoritesOnly = false;

  List<Product> get items{
    return [..._items];
  }

  List<Product> get favoritItems{
    return _items.where( (prodItem) => prodItem.isFavorite ).toList();
  }

  Product findById(String id){
    return _items.firstWhere( (product) => product.id == id );
  }

  Future<void> fetchAndSetProducts() async {
   const url       = 'https://flutter-update-32aaf.firebaseio.com/product.json';
    try{
      final response                    = await http.get(url);
      final extractData                 = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];

      extractData.forEach((prodId, productData){
        loadedProducts.add(Product(
          id: prodId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite']
        ));
       
        _items = loadedProducts;
        notifyListeners();
      });
    } catch (err){
      print(err);
      throw err;
    }
   
  }

  Future<void> addProduct(Product product) async {
    const url       = 'https://flutter-update-32aaf.firebaseio.com/product.json';
    try{

      final response  = await http.post(url, body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite
        })
      );

        final newProduct = Product(
                id: json.decode(response.body)['name'],
                title: product.title,
                description: product.description,
                price: product.price,
                imageUrl: product.imageUrl
              );
              
          _items.add(newProduct);
          notifyListeners();
    } catch (err){
        print(err);
        throw err;
    }

  }

  void updateProduct(String id, Product product) async {
    final prodIndex = _items.indexWhere( (prod) => prod.id == id);
    final url       = 'https://flutter-update-32aaf.firebaseio.com/product/$id.json';
    if(prodIndex >= 0){
       try{
         await http.patch(url, body: json.encode({
           'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
         }));
        _items[prodIndex] = product;
        notifyListeners();
       } catch(err) {
         throw err;
       }
    } else {
      print('....');
    }

  }

  Future<void> removeProduct(String id) async {
    final url       = 'https://flutter-update-32aaf.firebaseio.com/product/$id.json';
    final existingProductIndex  = _items.indexWhere( (prod) => prod.id == id );
    var existingProduct         = _items[existingProductIndex];
    _items.removeAt( existingProductIndex );
    notifyListeners();

    final response = await http.delete(url);

      if(response.statusCode >= 400){
        _items.insert(existingProductIndex, existingProduct);
        notifyListeners();
        throw HttpException('Could the delete product');
      }

      existingProduct = null;
  }

  Future<void> isFavoriteProduct(String id, bool isFavorites) async{
    final url                     = 'https://flutter-update-32aaf.firebaseio.com/product/$id.json';
     final existingProductIndex   = _items.indexWhere( (prod) => prod.id == id );
     var existingProduct         = _items[existingProductIndex];
    if(existingProductIndex >= 0){


        final response = await http.patch(url, body: json.encode({
          'isFavorite': isFavorites
        }));

        if(response.statusCode >= 400){
          //rollback data
          _items.insert(existingProductIndex, existingProduct);
          notifyListeners();
          throw HttpException('Could the delete product');
        }

        _items[existingProductIndex].isFavorite = isFavorites;
        notifyListeners();
     
       
    }
  }  
}