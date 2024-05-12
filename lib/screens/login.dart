import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vdoc/services/auth_service.dart';
import 'package:vdoc/widgets/my_button.dart';
import 'package:vdoc/widgets/my_textfield.dart';

class LoginPage extends StatelessWidget {

  //email and pw text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // tap to go to register page
  final void Function()? onTap;

   LoginPage({super.key, required this.onTap});

   //login method
  void login(BuildContext context) async {

    //auth service
    final authService = AuthService();

    // try login
    try {
      await authService.signInWithEmailPassword(
          _emailController.text,
          _passwordController.text,
      );
    }

    // catch any errors
    catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //logo
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 50,),

          //welcome back message
          Text(
              "Welcome Back",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 25,),

          //email Text field
          MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
          ),
          const SizedBox(height: 10,),

          // pw Text field
          MyTextField(
            hintText: "Password",
            obscureText: true,
            controller: _passwordController,
          ),
          const SizedBox(height: 25,),

          //login button
          // MyButton(
          //   text: "Login",
          //   onTap:() {
          //     login(context);
          //   },
          // ),
          // const SizedBox(height: 25,),

          TextButton(
              onPressed: ()=> login(context),
              child: const Text("Login")),
          const SizedBox(height: 25,),

          //Register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Not a member?  ",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                    "Register now",
                  style:
                      TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),

                ),
              ),

            ],
          ),
         ],
      ),
    );
  }




}
