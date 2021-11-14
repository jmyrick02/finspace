import 'package:finspace/Homepage/transaction.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Expenses extends StatelessWidget {
  final List<Transaction> transactions;
  const Expenses(this.transactions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, double> data_map = {};
    List<Transaction> expense_transactions =
        transactions.where((transaction) => transaction.amount <= 0).toList();
    double sum = 0;
    for (Transaction transaction in expense_transactions) {
      String cat = transaction.category.toString().split('.').last;
      sum -= transaction.amount;
      if (data_map.containsKey(cat)) {
        data_map[cat] = data_map[cat]! - transaction.amount;
      } else {
        data_map[cat] = -transaction.amount;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: Column(
        children: <Widget>[
              PieChart(
                dataMap: data_map,
                animationDuration: const Duration(milliseconds: 1000),
                chartValuesOptions:
                    const ChartValuesOptions(showChartValues: false),
              ),
            ] +
            data_map.keys
                .map((cat) => Text(cat + ': \$' + data_map[cat].toString()))
                .toList() +
            [Text('total: \$' + sum.toString())],
      ),
    );
  }
}
