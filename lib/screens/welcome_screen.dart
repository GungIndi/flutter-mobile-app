import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget{
const WelcomeScreen({super.key});
static String id = 'welcome_screen';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Welcomee!'
          )
        )
      ),
    );
  }
}