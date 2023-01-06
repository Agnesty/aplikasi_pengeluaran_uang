import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaksi_model.dart';

class EditTransaksiBaru extends StatefulWidget {
  final Function edit;
  final Transaksi transaksi;
  final Function? addListExpenses;
  const EditTransaksiBaru(
      {required this.edit,
      this.addListExpenses,
      required this.transaksi,
      super.key});

  @override
  State<EditTransaksiBaru> createState() => _EditTransaksiBaruState();
}

class _EditTransaksiBaruState extends State<EditTransaksiBaru> {
  final _expensesMadeForController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    _expensesMadeForController.text = widget.transaksi.expenses;
    _descriptionController.text = widget.transaksi.descript;
    _amountController.text = widget.transaksi.amount.toString();
    _selectedDate = widget.transaksi.chosenDate;
    super.initState();
  }

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredExpenses = _expensesMadeForController.text;
    final enteredDescription = _descriptionController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredExpenses.isEmpty ||
        enteredDescription.isEmpty ||
        enteredAmount <= 0 ||
        _selectedDate == null) {
      return;
    }

    widget.addListExpenses!(
        enteredExpenses, enteredDescription, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(
            20,
          ),
          child: Column(
            children: <Widget>[
              Text(
                'Add Amount',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextField(
                decoration: InputDecoration(label: Text('Expenses Made For')),
                controller: _expensesMadeForController,
                onSubmitted: (value) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(label: Text('Description')),
                controller: _descriptionController,
                onSubmitted: (value) => _submitData(),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(label: Text('Amount')),
                controller: _amountController,
                onSubmitted: (value) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(children: <Widget>[
                  Expanded(
                      child: Text(_selectedDate == null
                          ? 'No date choosen!'
                          : 'Picked Date : ${DateFormat.yMd().format(_selectedDate!)}')),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.edit(
                          widget.transaksi.id,
                          _expensesMadeForController.text,
                          _descriptionController.text,
                          double.parse(_amountController.text.toString()),
                          _selectedDate);
                    },
                    child: Card(
                      elevation: 5,
                      color: Colors.transparent,
                      child: Container(
                        width: 90,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.amber),
                        child: Center(
                            child: Text(
                          'Save',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
