import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController  = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData(){
    if(_amountController.text.isEmpty){
      return;
    }

    final enteredTitle  = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null){
      return;
    }

    // widget.addTx(
    //   enteredTitle,
    //   enteredAmount,
    //   _selectedDate
    // );

    Navigator.of(context).pop();
  }

  // void _presentDatePicker(){
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2019),
  //     lastDate: DateTime.now(),
  //   ).then( (pickDate) {
  //     if(pickDate == null){
  //       return;
  //     }
  //     setState(() {
  //       _selectedDate = pickDate;
  //     });
  //   });

  //   print('....');
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountController,
              onSubmitted: (_) => _submitData(),
            )
          ],
        ),
      ),
    );
  }
}