import 'package:finspace/Homepage/add_transaction.dart';
import 'package:finspace/Homepage/date.dart';
import 'package:finspace/Homepage/expenses.dart';
import 'package:finspace/Homepage/income.dart';
import 'package:finspace/Homepage/income_expense_overview.dart';
import 'package:finspace/Homepage/period.dart';
import 'package:finspace/Homepage/transaction.dart';
import 'package:finspace/Homepage/transaction_category.dart';
import 'package:finspace/Homepage/transaction_log.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _name = '';
  String _classYear = '';
  String _school = '';
  String _food = '';
  String _creditHours = '';
  String _housing = '';
  List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _name = prefs.getString('name') ?? _name;
      _classYear = prefs.getString('classYear') ?? _classYear;
      _school = prefs.getString('school') ?? _school;
      _food = prefs.getString('food') ?? _food;
      _creditHours = prefs.getString('creditHours') ?? _creditHours;
      _housing = prefs.getString('housing') ?? _housing;
      _transactions = (prefs.getStringList('transactions') ?? <String>[])
          .map((str) => parseTransactionString(str))
          .toList();
    });
  }

  Transaction parseTransactionString(String str) {
    List<String> parts = str.split('|');
    List<String> date_parts = parts[0].split('/');
    return Transaction(
      Date(int.tryParse(date_parts[0]) ?? -1, int.tryParse(date_parts[1]) ?? -1,
          int.tryParse(date_parts[2]) ?? -1),
      double.tryParse(parts[1]) ?? 0.0,
      TransactionCategory.values
          .firstWhere((element) => element.toString() == parts[2]),
      period:
          Period.values.firstWhere((element) => element.toString() == parts[3]),
      description: parts[4],
    );
  }

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
                  Text(
                    _name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _classYear,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    _school,
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
          final prefs = await SharedPreferences.getInstance();

          prefs.setStringList(
              'transactions',
              (prefs.getStringList('transactions') ?? ['']) +
                  [newTransaction.toString()]);
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
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Income(_transactions)))
                  },
                  child: const Text('Income'),
                ),
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Expenses(_transactions)))
                  },
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
