import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_1/components/components.dart';

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 50,
        // automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: user == null
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              )
            : Padding(
              padding: const EdgeInsets.fromLTRB(25, 33, 25 ,20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Edit Profile',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                    ),
                    )
                  ),
                  DisplayImage(
                    imagePath: "assets/images/profile.jpeg", 
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),
                  UserProfileData(
                    title: 'Name', 
                    value: user!['name'], 
                    onPressed: (){},
                  ),
                  UserProfileData(
                    title: 'Email', 
                    value: user!['email'], 
                    onPressed: (){},
                  ),
                  SizedBox(height: 70),
                  CustomButton(
                    text: 'Log Out', 
                    backgroundColor: Colors.red, 
                    textColor: Colors.white, 
                    onPressed: () {
                      logout(context);
                    },
                  ),
                ],
              ),
            ),
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