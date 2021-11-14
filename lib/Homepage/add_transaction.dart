import 'package:finspace/Homepage/date.dart';
import 'package:finspace/Homepage/period.dart';
import 'package:finspace/Homepage/transaction.dart';
import 'package:finspace/Homepage/transaction_category.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _formKey = GlobalKey<FormState>();

  int _typeDropdownValue = 1;
  Period _periodDropdownValue = Period.once;
  double _inputAmount = 0.0;
  String _inputDescription = '';
  int _inputDay = Date.now().day;
  int _inputMonth = Date.now().month;
  int _inputYear = Date.now().year;
  TransactionCategory _categoryDropdownValue = TransactionCategory.other;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text('Type: '),
                DropdownButton(
                  value: _typeDropdownValue,
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('income')),
                    DropdownMenuItem(value: -1, child: Text('expense'))
                  ],
                  onChanged: (value) {
                    setState(() {
                      _typeDropdownValue = value as int;
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.money),
                  labelText: 'Amount',
                ),
                onSaved: (text) {
                  _inputAmount = double.tryParse(text ?? 'null') ?? 0.0;
                },
                validator: (text) {
                  if (text!.contains('-')) {
                    return 'Must be a positive number';
                  }
                  return double.tryParse(text) == null
                      ? 'Must be a number.'
                      : null;
                },
              ),
            ),
            Row(
              children: [
                const Text('Category: '),
                DropdownButton(
                  value: _categoryDropdownValue,
                  items: TransactionCategory.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.toString().split('.')[1]),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _categoryDropdownValue = value as TransactionCategory;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('Period: '),
                DropdownButton(
                  value: _periodDropdownValue,
                  items: Period.values
                      .map((period) => DropdownMenuItem(
                            value: period,
                            child: Text(period.toString().split('.')[1]),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _periodDropdownValue = value as Period;
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.text_fields),
                  labelText: 'Description (optional)',
                ),
                onSaved: (text) {
                  _inputDescription = text ?? '';
                },
                validator: (text) {
                  return null;
                },
              ),
            ),
            const Text('Date (optional - leave blank for current date): '),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Day'),
                    onSaved: (text) {
                      _inputDay = int.tryParse(text ?? 'null') ?? _inputDay;
                    },
                    validator: (text) {
                      return null;
                    },
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Month'),
                    onSaved: (text) {
                      _inputMonth = int.tryParse(text ?? 'null') ?? _inputMonth;
                    },
                    validator: (text) {
                      return null;
                    },
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Year'),
                    onSaved: (text) {
                      _inputYear = int.tryParse(text ?? 'null') ?? _inputYear;
                    },
                    validator: (text) {
                      return null;
                    },
                  ),
                )),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.pop(
                      context,
                      Transaction(
                        Date(_inputDay, _inputMonth, _inputYear),
                        _inputAmount * _typeDropdownValue,
                        _categoryDropdownValue,
                        period: _periodDropdownValue,
                        description: _inputDescription,
                      ));
                }
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
