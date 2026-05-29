import 'package:flutter/material.dart';

import '../database/database.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';
import 'welcome_widget.dart';

class ProfileWidget extends StatefulWidget {
  final UserModel user;

  const ProfileWidget({super.key, required this.user,});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  List<TransactionModel> transactions = [];

  double totalIncome = 0;
  double totalExpense = 0;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    final data = await DatabaseHelper.instance.getTransactions(widget.user.id!);
    double income = 0;
    double expense = 0;

    for (var transaction in data) {
      if (transaction.type == 'income') {
        income += transaction.amount;
      } else {
        expense += transaction.amount;
      }
    }

    setState(() {
      transactions = data;
      totalIncome = income;
      totalExpense = expense;
    });
  }

  @override
  Widget build(BuildContext context) {
    final balance = totalIncome - totalExpense;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Profil",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Color(0xFF4F46E5),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 20),
                  Text(
                    widget.user.username,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),
                  const Text(
                    "Gider Takip Kullanıcısı",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: buildStatCard(
                    title: "İşlemler",
                    value:transactions.length.toString(),
                    icon: Icons.receipt_long,
                  ),
                ),

                const SizedBox(width: 15),
                Expanded(
                  child: buildStatCard(
                    title: "Bakiye",
                    value: "${balance.toStringAsFixed(2)} ₺",
                    icon: Icons.account_balance_wallet,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: buildStatCard(
                    title: "Gelir",
                    value: "+${totalIncome.toStringAsFixed(2)} ₺",
                    icon: Icons.arrow_downward,
                  ),
                ),

                const SizedBox(width: 15),
                Expanded(
                  child: buildStatCard(
                    title: "Gider",
                    value: "-${totalExpense.toStringAsFixed(2)} ₺",
                    icon: Icons.arrow_upward,
                  ),
                ),
              ],
            ),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18,),
                  ),
                ),

                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeWidget(),
                    ),
                    (route) => false,
                  );
                },

                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Çıkış",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatCard({
    required String title,
    required String value,
    required IconData icon,
  }) {

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xFF4F46E5),
            size: 32,
          ),

          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}