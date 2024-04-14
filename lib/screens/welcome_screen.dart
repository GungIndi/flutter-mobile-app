import 'package:flutter/material.dart';
import 'dart:math';

class WelcomeScreen extends StatelessWidget{
  const WelcomeScreen({super.key});
  static String id = 'welcome_screen';

  List<String> generateRandomList(int length) {
    List<String> randomList = [];
    Random random = Random();
    for (int i = 0; i < length; i++) {
      randomList.add('Item ${random.nextInt(100)}');
    }
    return randomList;
  }

  @override
  Widget build(BuildContext context){
    List<String> randomList = generateRandomList(10);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 33, 25 ,20),
          child: Center(
            child: ListView.builder(
              itemCount: randomList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(randomList[index]),
                );
              },
            )
          ),
        )
      ),
    );
  }
}