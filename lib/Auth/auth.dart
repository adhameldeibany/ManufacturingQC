import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pds_manufacturing_version/Home/home_main.dart';
import 'package:pds_manufacturing_version/Home/home_screen.dart';
import 'package:pds_manufacturing_version/Sign%20in/signin_screen.dart';

class Auth extends StatelessWidget{
  const Auth({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return HomeMain();
          }else{
            return SigninScreen();
          }
        }),
      ),
    );
  }
}