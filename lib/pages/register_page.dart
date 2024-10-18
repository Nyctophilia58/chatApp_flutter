import 'package:flutter/material.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import '../services/auth/auth_service.dart';


class RegisterPage extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap
  });

  void register(BuildContext context) async{
    final _auth = AuthService();

    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        await _auth.signUpWithEmailPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(context: context, builder: (context) =>
          AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }
    else{
      showDialog(context: context, builder: (context) => const AlertDialog(
          title: Text("Passwords do not match"),
        ),
      );
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

            Text("Let's create an account for you",
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

            const SizedBox(height: 10),

            MyTextField(
              obscureText: true,
              hintText: "Confirm password",
              controller: _confirmPasswordController,
            ),

            const SizedBox(height: 25),

            MyButton(
              text: "Register",
              onTap: () => register(context),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                const SizedBox(width: 5),

                GestureDetector(
                  onTap: onTap,
                  child: Text("Login now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                )

              ],
            ),
          ]
      ),
    );
  }
}