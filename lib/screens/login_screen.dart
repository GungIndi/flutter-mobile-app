import 'package:flutter/material.dart';
import 'package:project_1/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25 ,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,  
            children: [
              // Image.asset("assets/images/login.jpg"),
              Row(
                children: [
                  Text(
                    'Login to\nYour Account',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Image.asset(
                'assets/images/icons/accent.png',
                width: 110,
                height: 10,
              ),
              SizedBox(height: 35),
              Form(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color : InputField,
                        // border : Border.all(
                        //   color: Colors.blue,
                        //   width: 1
                        // )
                      ),                      
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        )
                      ),
                    ),
                    SizedBox(height: 32,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color : InputField,
                        // border : Border.all(
                        //   color: Colors.blue,
                        //   width: 1
                        // )
                      ),                         
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.visibility_outlined),
                            onPressed: () {},
                          )
                        )
                      ),
                    )
                  ],
                ) 
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      )
    );
  } 
}