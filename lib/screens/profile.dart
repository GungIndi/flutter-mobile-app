import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ProfilScreen extends StatefulWidget {
  ProfilScreen({Key? key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State{
  final apiUrl = 'https://mobileapis.manpits.xyz/api';
  final dio = Dio();
  final storage = GetStorage();
  Map<String, dynamic>? user;

Future<void> getUserData() async {
  try {
    Response response = await dio.post(
      "$apiUrl/user",
      options: Options(
        headers: {'Authorization' : 'Bearer ${storage.read('token')}'}
      ),
    );

    print('Response: $response');

    if (response.data['success'] == true) {
      Map<String, dynamic> data = response.data;
      user = data['user'];
      print('User: $user');
      setState(() {}); 
    }
  } catch (error) {
    print('Error occurred: $error');
  }
}


  @override
  void initState() {
    super.initState();
    getUserData();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('User Profile'),
    ),
    body: Center(
      child: user == null
          ? CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Name: ${user!['name']}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Email: ${user!['email']}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
      ),
    );
  }
}
