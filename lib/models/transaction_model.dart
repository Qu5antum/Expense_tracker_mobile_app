class TransactionModel {
  final int? id;
  final int userId;
  final String title;
  final double amount;
  final String type;
  final String category;
  final String date;

  TransactionModel({this.id, required this.userId, required this.title, required this.amount, required this.type, required this.category, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'amount': amount,
      'type': type,
      'category': category,
      'date': date,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(id: map['id'], userId: map['userId'], title: map['title'], amount: map['amount'], type: map['type'], category: map['category'], date: map['date']);
  }
}