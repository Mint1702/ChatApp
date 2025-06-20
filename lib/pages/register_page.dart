import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  //email and password controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  //tap to go to login page
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  //register method
  void register(BuildContext context) {
    //get auth service
    final _auth = AuthService();

  //create user if passwords match
    if (_passwordController.text == _confirmPwController.text) {
      try {
        _auth.signUpWithEmailPW(
          _emailController.text,
          _passwordController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text("Error"),
                content: Text(e.toString()),
              ),
        );
      }
    }
    //show error if passwords dont match
    else {
      showDialog(
          context: context,
          builder:
              (context) => const AlertDialog(
                title: Text("Error"),
                content: Text("Passwords don't match."),
              ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 50),

          //welcome message
          Text(
            "Welcome From MyText App",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 25),

          //email textfield
          MyTextField(
            hintText: "Email",
            obscureText: false,
            controller: _emailController,
          ),

          const SizedBox(height: 10),

          //pw textfield
          MyTextField(
            hintText: "Password",
            obscureText: true,
            controller: _passwordController,
          ),
          const SizedBox(height: 10),

          //confirm pw textfield
          MyTextField(
            hintText: "Confirm Password",
            obscureText: true,
            controller: _confirmPwController,
          ),
          const SizedBox(height: 25),

          //register button
          MyButton(text: "Register", onTap: () => register(context)),

          const SizedBox(height: 25),

          //register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login now",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
