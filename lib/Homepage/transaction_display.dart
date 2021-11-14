import 'package:finspace/Homepage/transaction.dart';
import 'package:flutter/material.dart';

class TransactionDisplay extends StatelessWidget {
  final Transaction transaction;
  const TransactionDisplay(this.transaction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('display');
    return Column(
      children: [
        Text(transaction.date.toString() +
            ' - \$' +
            transaction.amount.toString()),
        Text(transaction.category.toString().split('.').last +
            ' | ' +
            transaction.period.toString().split('.').last),
        Text(transaction.description),
        Divider(
          thickness: 2,
        )
      ],
    );
  }
}
