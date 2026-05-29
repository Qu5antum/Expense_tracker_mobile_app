import 'package:flutter/material.dart';

import '../database/database.dart';
import '../models/user_model.dart';
import 'login_widget.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> register() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    
    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Tüm alanları doldurun",
          ),
        ),
      );
      return;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Şifreler eşleşmiyor",
          ),
        ),
      );
      return;
    }
    final user = UserModel(
      username: username,
      password: password,
    );
    await DatabaseHelper.instance.insertUser(user);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Kayıt başarılı",
        ),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const LoginWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Kayıt Ol"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Column(
        children: [
          Image.asset(
            "images/login_logo.jpg",
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText:"Kullanıcı adı: ",
                filled: true,
                fillColor: Color.fromARGB(255, 108, 104, 193),
                border: OutlineInputBorder(
                  borderRadius:BorderRadius.all(Radius.circular(5),),
                ),
              ),
            ),
          ),

          Padding(
            padding:const EdgeInsets.all(20),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Şifre: ",
                filled: true,
                fillColor: Color.fromARGB(255, 108, 104, 193),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5),),
                ),
              ),
            ),
          ),
          Padding(
            padding:const EdgeInsets.all(20),
            child: TextField(
              controller:confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Şifre tekrar: ",
                filled: true,
                fillColor: Color.fromARGB(255, 108, 104, 193),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5),),
                ),
              ),
            ),
          ),

          ElevatedButton(
            onPressed: register,
            child: const Text(
              "Kayıt Ol",
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const LoginWidget(),
                ),
              );
            },

            child: const Text(
              "Zaten hesabın var mı? Giriş yap",
            ),
          ),
        ],
      ),
    );
  }
}