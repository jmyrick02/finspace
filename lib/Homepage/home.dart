import 'package:finspace/Homepage/income_expense_overview.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                children: const [
                  Text(
                    'John Doe',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Sophomore',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Computer Science',
                    style: TextStyle(fontSize: 20),
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
          const IncomeExpenseOverview(),
          ElevatedButton(
            onPressed: () => {},
            child: const Text('Transaction Log'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
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
                  onPressed: () => {},
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
