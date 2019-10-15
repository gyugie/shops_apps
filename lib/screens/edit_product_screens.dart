import 'package:flutter/material.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Form(
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