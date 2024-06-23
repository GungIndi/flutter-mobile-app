import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/bloc/bottomBar/bottom_bar_bloc.dart';
import 'package:project_1/screens/dashboard_screen.dart';
import 'package:project_1/screens/profile.dart';

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    label: 'Member',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outlined),
    label: 'Profile',
  )
];

List<Widget> bottomNavScreen = <Widget>[
    DashboardScreen(),
    ProfileScreen(),
];

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomBarBloc, BottomBarState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(child: bottomNavScreen.elementAt(state.tabIndex)),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomNavItems,
            currentIndex: state.tabIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              BlocProvider.of<BottomBarBloc>(context)
                  .add(TabChange(tabIndex: index));
            },
          ),
        );
      },
    ); 
  }
}