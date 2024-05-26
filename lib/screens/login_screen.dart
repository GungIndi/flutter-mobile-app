import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_1/components/components.dart';
import 'package:project_1/components/loginRegisterComponents.dart';



class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
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
                    login(emailController, passwordController, context);
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
                SocialMediaIcon(),
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
                        Navigator.pushReplacementNamed(context, '/register');
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

void login(emailController, passwordController, context) async {
  final dio = Dio();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';
  final storage = GetStorage();
  try{
    final response = await dio.post(
      "$apiUrl/login", 
      data: {
        "email": emailController.text,
        "password": passwordController.text
      }
    );

    print (response.data['data']['token']);
    storage.write('token', response.data['data']['token']);

    if (response.data['success'] == true) {
      Navigator.pushNamed(
        context,
        '/buttom'
      );
    }
  } on DioException catch (error) {
    print(" Error : ${error.response?.statusCode} - ${error.response?.data} ");
    if (error.response != null && error.response!.data is Map<String, dynamic>) {
      String errorMessage = "hello" ;
      if (error.response!.data['message'].contains('Something error')){
        if(error.response!.data['data']['errors'].containsKey('email')){
          errorMessage = 'The email field must be a valid email address';
        } else if(error.response!.data['data']['errors'].containsKey('password')){
          errorMessage = 'The password field must be at least 6 characters';
        }
      }
      if(error.response!.data['message'].contains('Invalid')){
        errorMessage = error.response!.data['message'];
      }
      print(error.response!.data);
      showDialog<String>(
        context: context, 
        builder: (BuildContext context) => AlertDialog(
          title: const Text('An Error Occured!'),
          content: Text('${errorMessage}'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'No'),
              child: Text('Ok')
            )
          ],
        )    
      );
    }
  }
}