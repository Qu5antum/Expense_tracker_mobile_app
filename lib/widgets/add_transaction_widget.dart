import 'package:flutter/material.dart';

import '../database/database.dart';
import 'package:expense_tracker/models/transaction_model.dart';
import 'package:expense_tracker/models/user_model.dart';


class AddTransactionWidget extends StatefulWidget {
  final UserModel user;

  const AddTransactionWidget({super.key, required this.user});

  @override
  State<AddTransactionWidget> createState() => _AddTransactionWidgetState();
}

class _AddTransactionWidgetState extends State<AddTransactionWidget> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  String selectedType = 'expense';
  String selectedCategory = 'Yemek';

  final categories = ['Yemek', 'Ulaşım', 'Alışveriş', 'Maaş', 'Eğlence'];

  Future<void> saveTransation() async {
    if (titleController.text.isEmpty || amountController.text.isEmpty) {
      return;
    }

    final transaction = TransactionModel(userId: widget.user.id!, title: titleController.text, amount: double.parse(amountController.text), type: selectedType, category: selectedCategory, date: DateTime.now().toString(),);

    await DatabaseHelper.instance.insertTransaction(transaction);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İşlem ekle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Başlık',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Miktar',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20,),
            DropdownButtonFormField<String>(
              value: selectedType,
              items: const [
                DropdownMenuItem(
                  value: 'income',
                  child: Text('Gelir'),
                ),
                DropdownMenuItem(
                  value: 'expense',
                  child: Text('Gider'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedType = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'İşlem Türü',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20,),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveTransation, 
                child: const Text('İşlemi Kaydet'),
              ),
            ),
          ],
        ),
      )
    );
  }
}