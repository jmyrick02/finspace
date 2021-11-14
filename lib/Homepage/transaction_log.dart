import 'package:finspace/Homepage/transaction.dart';
import 'package:finspace/Homepage/transaction_display.dart';
import 'package:flutter/material.dart';

class TransactionLog extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionLog(this.transactions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction Log')),
      body: ListView(
        children: transactions
            .map((transaction) => TransactionDisplay(transaction))
            .toList(),
      ),
    );
  }
}
