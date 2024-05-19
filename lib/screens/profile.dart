import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_1/components/components.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State{
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
  } on DioException catch (error) {
    print('Error occurred: ${error.response}');
    String errorMessage = error.response!.data['message'];
    if (error.response!.data['message'] != null && error.response!.data['message'].contains('Token is Expired')) {
       errorMessage = 'Your Session is Over';
    }
    showDialog<String>(
      context: context, 
      builder: (BuildContext context) => AlertDialog(
        title: Text('${errorMessage}'),
        content: Text('Please Login'),
        actions: <Widget>[
          TextButton(
            onPressed: () =>  Navigator.pushReplacementNamed(context, '/login'),
            child: Text('Ok')
          )
        ],
      )    
    );
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
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        toolbarHeight: 75,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: user == null
          ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          )
          : SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 33, 25 ,20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
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

    if (response.data['success'] == true) {
      Navigator.pushNamed(
        context,
        '/login'
      );
    }
  } on DioException catch (e){
    print(e.message);
  }
}