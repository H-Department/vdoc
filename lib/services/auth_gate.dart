import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vdoc/services/login_register.dart';

import '../screens/home.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          // user is logged in
          if (snapshot.hasData) {
            return HomePage();
          }

          // user in NOT logged in
          else {
            return const LoginOrRegister();
          }

        },


      ),
    );
  }
}
