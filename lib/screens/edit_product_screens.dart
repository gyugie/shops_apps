import 'package:flutter/material.dart';
import '../providers/product.dart';

class EditPoruductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditPoruductScreenState createState() => _EditPoruductScreenState();
}

class _EditPoruductScreenState extends State<EditPoruductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocusNode     = FocusNode();
  final _form               = GlobalKey<FormState>();
  var _editedProduct        = Product(id: null,title: '', description: '', price: 0, imageUrl: '');

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
    _form.currentState.save();
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.description);
    print(_editedProduct.imageUrl);
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
              decoration: InputDecoration(
                labelText: 'Title'
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              onSaved: (value){
                _editedProduct = Product(
                    id: null, 
                    title: value,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl
                  );
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Price'
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              onSaved: (value){
                _editedProduct = Product(
                    id: null, 
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: value.isEmpty ? 0 : double.parse(value),
                    imageUrl: _editedProduct.imageUrl
                  );
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description'
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              focusNode: _descriptionFocusNode,
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_imageFocusNode);
              },
              onSaved: (value){
                _editedProduct = Product(
                    id: null, 
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
                  onFieldSubmitted: (_) {
                        _saveProduct();
                      },
                  onSaved: (value){
                  _editedProduct = Product(
                    id: null, 
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