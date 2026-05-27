import 'package:expense_tracker/widgets/add_transaction_widget.dart';
import 'package:flutter/material.dart';

import '../database/database.dart';
import 'package:expense_tracker/models/transaction_model.dart';
import 'package:expense_tracker/models/user_model.dart';


class HomeWidget extends StatefulWidget {
  final UserModel user;

  const HomeWidget({super.key, required this.user});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<TransactionModel> transactions = [];

  @override
  void initState() {
    super.initState();

    loadTransactions();
  }

  Future<void> loadTransactions() async {
    final data = await DatabaseHelper.instance.getTransactions(widget.user.id!);

    setState(() {
      transactions = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Ana Sayfa"),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];

          return ListTile(
            title: Text(transaction.title),
            subtitle: Text(transaction.category),
            trailing: Text('${transaction.amount}'),
          );
        }, 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTransactionWidget(user: widget.user)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}