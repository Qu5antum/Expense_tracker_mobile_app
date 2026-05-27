import 'package:flutter/material.dart';

import '../database/database.dart';
import 'home_widget.dart';


class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    final user = await DatabaseHelper.instance.login(usernameController.text, passwordController.text);

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Yanlış şifre ya da kullanıcı adı"))
      );
    }
    else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeWidget(user: user)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Giriş"),
      ),
      body: Column(
        children: [
          Image.asset("images/login_logo.jpg"),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "Kullanıcı adı: ",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Şifre: ",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
              ),
            ),
          ),
        ElevatedButton(onPressed: login, child: const Text("Giriş"))
        ],
      ),
    );
  }
}