import 'package:flutter/material.dart';
import 'package:project_1/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String id = 'home_screen'; 

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children:[
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 75, 25 ,20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Image.asset("assets/images/welcome.jpg"),
                    ),
                    SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hello!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Welcome to My App, where you just confused what kind of app is this',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),  
                    SizedBox(height: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          text: 'Login', 
                          backgroundColor: Colors.blue, 
                          textColor: Colors.white, 
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/login');
                          }
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: 'Sign Up', 
                          backgroundColor: Colors.white, 
                          textColor: Colors.blue, 
                          borderColor: Colors.blue,
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/register');
                          }
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}