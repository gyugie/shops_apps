import 'package:flutter/material.dart';

class EditPoruductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditPoruductScreenState createState() => _EditPoruductScreenState();
}

class _EditPoruductScreenState extends State<EditPoruductScreen> {
  final _priceFocusNode = FocusNode();

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
            ),
          ],
        ),
      ),
    );
  }
}