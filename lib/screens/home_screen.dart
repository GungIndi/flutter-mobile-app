import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_1/screens/login_screen.dart';
import 'package:project_1/screens/signup_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String id = 'home_screen'; 

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children:[
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 33, 25 ,20),
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          minimumSize: Size(double.infinity, 56),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18, 
                            color: Colors.white,
                            fontWeight: FontWeight.w600
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
                          side: BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          minimumSize: Size(double.infinity, 56)
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18, 
                            color: Colors.blue,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}