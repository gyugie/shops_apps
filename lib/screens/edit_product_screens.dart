import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode       = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController   = TextEditingController();
  final _imageFocusNode       = FocusNode();
  final _form                 = GlobalKey<FormState>();
  var _editedProduct          = Product(id: null,title: '', description: '', price: 0, imageUrl: '');
  var _isInit                 = true;
  var _initValues             = {'title':'','description':'','price':'','imageUrl':''};

  @override 
  void initState(){
     _imageFocusNode.addListener(_updateImageUrl);
     super.initState();
  }

  @override
  void dispose(){
    _imageFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl(){
    if(!_imageFocusNode.hasFocus){
      setState(() {
        
      });
    }
  }

  void _saveProduct(){
    final validate = _form.currentState.validate();

    if(!validate){
      return;
    }

    _form.currentState.save();
    if(_editedProduct.id == null){
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).updateProduct(_editedProduct.id, _editedProduct);
    }

    Navigator.of(context).pop();
  }


  //for updateing product
  @override
  void didChangeDependencies(){
    
    if(_isInit){
      final productId         = ModalRoute.of(context).settings.arguments as String;
      if(productId != null){
        _editedProduct  =  Provider.of<Products>(context).findById(productId);
        _initValues           = {
                                'title':_editedProduct.title,
                                'description': _editedProduct.description,
                                'price': _editedProduct.price.toString(),
                                };
        _imageUrlController.text = _editedProduct.imageUrl;
      }

    }

    _isInit = false;
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveProduct,
          )
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            TextFormField(
              initialValue: _initValues['title'],
              decoration: InputDecoration(
                labelText: 'Title'
              ),
              textInputAction: TextInputAction.next,
              validator: (value){ 
                if(value.isEmpty){
                  return 'Title is required!';
                }
                return null;
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              onSaved: (value){
                _editedProduct = Product(
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite, 
                    title: value,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl
                  );
              },
            ),
            TextFormField(
              initialValue: _initValues['price'],
              decoration: InputDecoration(
                labelText: 'Price'
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
               validator: (value){ 
                if(value.isEmpty){
                  return 'Price is required!';
                }

                if(double.tryParse(value) == null){
                  return 'Please enter a valid number';
                }

                if(double.parse(value) <= 0){
                  return 'Please enter a number greater than zero';
                }

                return null;
              },
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              onSaved: (value){
                _editedProduct = Product(
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: value.isEmpty ? 0 : double.parse(value),
                    imageUrl: _editedProduct.imageUrl
                  );
              },
            ),
            TextFormField(
              initialValue: _initValues['description'],
              decoration: InputDecoration(
                labelText: 'Description'
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              focusNode: _descriptionFocusNode,
               validator: (value){ 
                if(value.isEmpty){
                  return 'Description is required!';
                }

                if(value.length < 10){
                  return 'Should be at least a long text';
                }

                return null;
              },
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_imageFocusNode);
              },
              onSaved: (value){
                _editedProduct = Product(
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite,
                    title: _editedProduct.title,
                    description: value,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl
                  );
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(
                    top: 8,
                    right: 10
                  ),
                  decoration: BoxDecoration(
                    border: 
                    Border.all(
                      width: 1,
                      color: Colors.grey
                    ),
                  ),
                  child: _imageUrlController.text.isEmpty 
                  ? 
                  Text('Enter URL Image') 
                  : 
                  FittedBox(
                    child: Image.network(_imageUrlController.text),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                  decoration: InputDecoration(labelText: 'Image URL'),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  controller: _imageUrlController,
                  focusNode: _imageFocusNode,
                  validator: (value){ 
                    if(value.isEmpty){
                      return 'Image URL is required!';
                    }

                    if(!value.startsWith('http') && !value.startsWith('https')){
                      return 'Please enter a valid URL';
                    }

                    return null;
                  },
                  onFieldSubmitted: (_) {
                        _saveProduct();
                      },
                  onSaved: (value){
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: value
                  );
                 },
                ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}