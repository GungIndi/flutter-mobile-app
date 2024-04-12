import 'package:flutter/material.dart';
import 'package:project_1/screens/login_screen.dart';
import 'package:project_1/screens/signup_screen.dart';
import 'package:project_1/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String id = 'home_screen'; 

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset("assets/images/welcome1.jpg"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Text(
                  'Welcome!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    fontFamily: 'Ubuntu',
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                      'Welcome to My App, where you just confused what kind of app is this',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),  
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(33, 150, 243, 1),  
                      padding: EdgeInsets.fromLTRB(130, 15, 130, 15)
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,  
                      padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
                      side: BorderSide(color: Colors.blue)
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            const Text(
              'Sign up Using',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                    radius: 25,
                    child: Image.asset('assets/images/icons/facebook.png'),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child:
                        Image.asset('assets/images/icons/google.png'),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                    radius: 25,
                    child: Image.asset('assets/images/icons/linkedin.png'),
                  ),
                ),
              ]
            ),
          ]
        ),
      ),
    );
  }
}