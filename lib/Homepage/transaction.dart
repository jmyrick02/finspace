import 'package:finspace/Homepage/date.dart';
import 'package:finspace/Homepage/period.dart';
import 'package:finspace/Homepage/transaction_category.dart';

class Transaction {
  Date date;
  double amount;
  Period period;
  String description;
  TransactionCategory category;

  Transaction(this.date, this.amount, this.category,
      {this.period = Period.once, this.description = ''});

  Transaction.now(this.amount, this.category,
      {this.period = Period.once, this.description = ''})
      : date = Date.now();

  @override
  String toString() {
    return date.toString() +
        '|' +
        amount.toString() +
        '|' +
        category.toString() +
        '|' +
        period.toString() +
        '|' +
        description +
        ' ';
  }
}
