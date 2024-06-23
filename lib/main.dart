import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/bloc/bottomBar/bottom_bar_bloc.dart';
import 'package:project_1/screens/landingPage.dart';
import 'package:project_1/screens/addMember.dart';
import 'package:project_1/screens/home_screen.dart';
import 'package:project_1/screens/login_screen.dart';
import 'package:project_1/screens/profile.dart';
import 'package:project_1/screens/register_screen.dart';
import 'package:project_1/screens/dashboard_screen.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomBarBloc>(
          create: (context) => BottomBarBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => HomeScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/dashboard': (context) => DashboardScreen(),
          '/profile': (context) => ProfileScreen(),
          '/landingPage': (context) => LandingPage(),
          '/addMember': (context) => AddMemberScreen(),
        },
        initialRoute: '/',
      ),
    );
  }
}