import 'package:flutter/material.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/components/my_button.dart';
import '../services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void Function()? onTap;

  LoginPage({
    super.key,
    required this.onTap
  });

  void login(BuildContext context) async{
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text(e.toString()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
              Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),

          const SizedBox(height: 20),

          Text("Welcome back, you've been missed!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 20),

          MyTextField(
            obscureText: false,
            hintText: "Email",
            controller: _emailController,
          ),

          const SizedBox(height: 10),

          MyTextField(
            obscureText: true,
            hintText: "Password",
            controller: _passwordController,
          ),

          const SizedBox(height: 25),

          MyButton(
            text: "Login",
            onTap: () => login(context),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Not a member?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(width: 5),

              GestureDetector(
                onTap: onTap,
                child: Text("Register now",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ],
          ),
        ]
      ),
    );
  }
}