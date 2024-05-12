import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_1/components/components.dart';
import 'package:project_1/components/loginRegisterComponents.dart';

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
                    SignUp(usernameController, emailController, passwordController, context);
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
                SocialMediaIcon(),
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
                        Navigator.pushReplacementNamed(
                            context,
                            '/login'
                        );
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

void SignUp(usernameController, emailController, passwordController, context) async {
  final dio = Dio();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  try{
    final response = await dio.post("$apiUrl/register", data: {
      "name" : usernameController.text,
      "email": emailController.text,
      "password": passwordController.text
    });
    print (response.data);
  
    if (response.data['success'] == true) {
      Navigator.pushNamed(
        context,
        '/login'
      );
    }
  } on DioException catch (e) {
    print(" Error ${e.response?.statusCode} - ${e.response?.data} ");
  }
}


