import 'package:flutter/material.dart';
import 'package:project_1/components/components.dart';
import 'package:project_1/screens/signup_screen.dart';
import 'package:project_1/screens/welcome_screen.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static String id = 'login_screen';
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
                CustomCheckbox(
                  inactiveColor: Colors.white,
                  activeColor: Colors.blue,
                  text: 'Remember me',
                ),
                SizedBox(height: 50),
                CustomButton(
                  text: 'Login', 
                  backgroundColor: Colors.blue, 
                  textColor: Colors.white, 
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen())
                    );
                  }
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
                SizedBox(height: 40),
                Row(
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
              ],
            ),
          ),
        ),
      )
    );
  } 
}