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
      Response response = await dio.get(
        "$apiUrl/user",
        options: Options(
          headers: {'Authorization': 'Bearer ${storage.read('token')}'},
        ),
      );

      print('Response: $response');

      if (response.data['success'] == true) {
        Map<String, dynamic> data = response.data;
        user = data['data']['user'];
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
        title: Text('User Profile', style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: user == null
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Name: ${user!['name']}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Email: ${user!['email']}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      logout(context);
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

void logout(context) async {
  final dio = Dio();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';
  final storage = GetStorage();
  try{
    final response = await dio.get(
      "$apiUrl/logout", 
      options : Options(
        headers: {'Authorization' : 'Bearer ${storage.read('token')}'})
    );
    print(response.data);
    storage.remove('token');
    print(storage.read('token'));

    if (response.data['success'] == true) {
      Navigator.pushNamed(
        context,
        '/login'
      );
    }

  } on DioException catch (e){
  }
}