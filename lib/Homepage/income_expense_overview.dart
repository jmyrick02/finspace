import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class IncomeExpenseOverview extends StatelessWidget {
  const IncomeExpenseOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PieChart(
              dataMap: const {"Income": 1000, "Expenses": 500},
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
                  onPressed: () => {},
                  child: const Text(
                    'Income: \$1000',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () => {},
                  child: const Text(
                    'Expenses: \$500',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                // ignore: prefer_const_constructors
                TextButton(
                  onPressed: () => {},
                  child: const Text('Net: \$500'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
