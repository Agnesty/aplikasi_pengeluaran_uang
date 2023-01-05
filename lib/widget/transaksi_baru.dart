import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransaksiBaru extends StatefulWidget {
  final Function addListExpenses;
  const TransaksiBaru({required this.addListExpenses, super.key});

  @override
  State<TransaksiBaru> createState() => _TransaksiBaruState();
}

class _TransaksiBaruState extends State<TransaksiBaru> {
  final _expensesMadeForController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

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

    widget.addListExpenses(
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
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 80,
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
                  ),),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: _submitData,
                child: Container(
                  width: 90,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.amber),
                  child: Center(
                      child: Text(
                    'Add',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )),
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
