import 'package:finspace/Homepage/expenses.dart';
import 'package:finspace/Homepage/income.dart';
import 'package:finspace/Homepage/transaction.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class IncomeExpenseOverview extends StatelessWidget {
  final List<Transaction> transactions;

  const IncomeExpenseOverview(this.transactions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double income_amount = 0;
    double expense_amount = 0;
    for (Transaction transaction in transactions) {
      if (transaction.amount >= 0) {
        income_amount += transaction.amount;
      } else {
        expense_amount -= transaction.amount;
      }
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PieChart(
              dataMap: {"Income": income_amount, "Expenses": expense_amount},
              animationDuration: const Duration(milliseconds: 1000),
              colorList: const [Colors.green, Colors.red],
              legendOptions: const LegendOptions(showLegends: false),
              chartValuesOptions:
                  const ChartValuesOptions(showChartValues: false),
              chartRadius: MediaQuery.of(context).size.width / 2.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Income(transactions)))
                  },
                  child: Text(
                    'Income: \$' + income_amount.toString(),
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Expenses(transactions)))
                  },
                  child: Text(
                    'Expenses: \$' + expense_amount.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () => {},
                  child: Text(
                      'Net: \$' + (income_amount - expense_amount).toString()),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
