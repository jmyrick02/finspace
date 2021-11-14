import 'package:finspace/Homepage/add_transaction.dart';
import 'package:finspace/Homepage/income_expense_overview.dart';
import 'package:finspace/Homepage/transaction.dart';
import 'package:finspace/Homepage/transaction_category.dart';
import 'package:finspace/Homepage/transaction_log.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Transaction> _transactions = [
    Transaction.now(1, TransactionCategory.allowance),
    Transaction.now(-2, TransactionCategory.food),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/person.jpg'),
                  radius: 50,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'John Doe',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Sophomore',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Text(
                    'Computer Science',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Balance: \$' +
                        _transactions
                            .fold(
                                0.0,
                                (previousValue, element) =>
                                    (previousValue as double) + element.amount)
                            .toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            height: 20,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          IncomeExpenseOverview(_transactions),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TransactionLog(_transactions)));
            },
            child: const Text('Transaction Log'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Transaction newTransaction = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const AddTransaction(),
                fullscreenDialog: true,
              ));
          setState(() {
            _transactions.add(newTransaction);
          });
        },
        child: const Icon(Icons.add),
      ),
      drawer: SizedBox(
        width: 200,
        child: Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () => {},
                  child: const Text('Income'),
                ),
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () => {},
                  child: const Text('Expenses'),
                ),
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TransactionLog(_transactions)))
                  },
                  child: const Text('Transaction Log'),
                ),
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () => {},
                  child: const Text('Settings'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
