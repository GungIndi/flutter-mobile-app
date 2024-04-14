import 'package:flutter/material.dart';
import 'package:project_1/constants.dart';
import 'package:project_1/screens/signup_screen.dart';
import 'package:project_1/screens/welcome_screen.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 33, 25 ,20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,  
            children: [
              Row(
                children: [
                  Text(
                    'Login to\nYour Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 19),
              Image.asset(
                'assets/images/icons/accent.png',
                width: 110,
                height: 10,
              ),
              SizedBox(height: 53),
              Form(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color : InputField,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8.0, 10, 0),
                    child: Text(
                      'Forgot Password ?',
                      style: TextStyle(
                        fontWeight: FontWeight.w500
                      ),),
                  ),       
                ],           
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {
                    },
                  ),
                  Text('Remember me', style: TextStyle(fontSize: 16,)),
                ],
              ),
              SizedBox(height: 50),
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
                        builder: (context) => WelcomeScreen()));
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18, 
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Column(
                children: [
                  Center(
                    child: Text(
                      'OR',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 25),
                  Center(
                    child: Text(
                      'Log In With',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: CircleAvatar(
                      radius: 22,
                      child: Image.asset('assets/images/icons/facebook.png'),
                    ),
                  ),
                  SizedBox(width: 12),
                  IconButton(
                    onPressed: () {},
                    icon: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.transparent,
                      child: Image.asset('assets/images/icons/google.png'),
                    ),
                  ),
                  SizedBox(width: 12),
                  IconButton(
                    onPressed: () {},
                    icon: CircleAvatar(
                      radius: 22,
                      child: Image.asset('assets/images/icons/linkedin.png'),
                    ),
                  ),
                ]
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.grey ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                        color: const Color.fromARGB(255, 14, 124, 215) ),
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  } 
}