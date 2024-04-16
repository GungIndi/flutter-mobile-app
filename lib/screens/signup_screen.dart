import 'package:flutter/material.dart';
import 'package:project_1/components/components.dart';
import 'package:project_1/constants.dart';
import 'package:project_1/screens/login_screen.dart';
import 'package:project_1/screens/welcome_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  static String id = 'signup_screen';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 33, 25 ,20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,  
              children: [
                Row(
                  children: [
                    Text(
                      'Register\nNew Account',
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
                      InputField(
                        hintText: 'Username', 
                        controller: usernameController,
                      ),
                      SizedBox(height: 32),
                      InputField(
                        hintText: 'Email',
                        controller: emailController,
                        obscureText: false,
                      ),
                      SizedBox(height: 32,),
                      InputField(
                        hintText: 'Password',
                        controller: passwordController,
                        obscureText: true,
                        suffixIcon: true,
                      ),
                    ],
                  ) 
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    CustomCheckbox(
                      inactiveColor: Colors.white,
                      activeColor: Colors.blue,
                      text: 'Agree to our Terms & Condition',
                    ),
                  ],
                ),
                SizedBox(height: 35),
                CustomButton(
                  text: 'Register', 
                  backgroundColor: Colors.blue, 
                  textColor: Colors.white, 
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen())
                    );
                  }
                ), 
                SizedBox(height: 10),
                Column(
                  children: [
                    Center(
                      child: Text(
                        'OR',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Register With',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
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
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.grey ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  } 
}
