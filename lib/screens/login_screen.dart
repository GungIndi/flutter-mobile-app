import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset("assets/images/login.jpg"),
            Expanded(
              child: Center(
                child: Text(
                  'INI TEMPAT LOGIN',
                  style: TextStyle(
                    fontFamily: 'Montserrat'
                  ),),
              )
            ),
          ],
        ),
      )
    );
  } 
}