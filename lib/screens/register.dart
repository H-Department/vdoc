import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vdoc/services/auth_service.dart';

import '../widgets/my_button.dart';
import '../widgets/my_textfield.dart';

class RegisterPage extends StatelessWidget {

  //email and pw text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // tap to go to register page
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});


  // register method
  void register(BuildContext context) {
    // get auth service
    final _auth = AuthService();

      // the password match -> create user
    if (_passwordController.text == _confirmPasswordController.text){
      try {
        _auth.signUpWithEmailPassword(
            _emailController.text,
            _passwordController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),);
      }
    }

      //password don't match -> tell user to fix
     else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords Don't match!"),
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

          // Register message
          Text(
            "Let's Create an account for you",
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
          const SizedBox(height: 10,),

          // confirm password field,
          MyTextField(
            hintText: "Confirm Password",
            obscureText: true,
            controller: _confirmPasswordController,
          ),
          const SizedBox(height: 25,),

          //login button
          // MyButton(
          //   text: "Register",
          //   onTap: ()=> register(context),
          // ),
          // const SizedBox(height: 25,),
          TextButton(
              onPressed: () => register(context),
              child: const Text("Register")),
          const SizedBox(height: 25,),

          //Register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?  ",
                style:
                TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login now",
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
