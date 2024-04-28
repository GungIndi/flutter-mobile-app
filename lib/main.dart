import 'package:flutter/material.dart';
import 'package:project_1/screens/home_screen.dart';
import 'package:project_1/screens/login_screen.dart';
import 'package:project_1/screens/profile.dart';
import 'package:project_1/screens/signup_screen.dart';
import 'package:project_1/screens/welcome_screen.dart';
import 'package:get_storage/get_storage.dart';
Future<void> main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => SignUpScreen(),
        '/dashboard': (context) => WelcomeScreen(),
        '/profile': (context) => ProfilScreen(),
      },
      initialRoute: '/',
    );
  }
}