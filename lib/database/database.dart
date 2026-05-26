import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/transaction_model.dart';
import '../models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
     await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        type TEXT NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL,
        FOREIGN KEY(user_id) REFERENCES users(id)
      )
    ''');

    await db.insert(
      'users',
      {
        'username': 'testuser1',
        'password': '123'
      },
    );
  }
  
  /* kullanıcı ekleme metodu */
  Future<int> insertUser(UserModel user) async {
    final db = await instance.database;

    return await db.insert('users', user.toMap(),);
  }

  /* işlem ekleme metodu */
  Future<int> insertTransaction(TransactionModel transaction) async {
    final db = await instance.database;

    return await db.insert('transactions', transaction.toMap(),);
  }

  /* işlemleri al metodu */
  Future<List<TransactionModel>> getTransactions(int userId,) async {
    final db = await instance.database;

    final result = await db.query('transactions', where: 'user_id = ?', whereArgs: [userId], orderBy: 'date DESC',);

    return result.map((json) => TransactionModel.fromMap(json)).toList();
  }
  
  /* login metodu */
  Future<UserModel?> login(String username, String password) async {
    final db = await instance.database;
    
    final result = await db.query('users', where: 'username = ? AND password = ?', whereArgs: [username, password]);

    if (result.isEmpty) {
      return null;
    }

    return UserModel.fromMap(result.first);
  }
}