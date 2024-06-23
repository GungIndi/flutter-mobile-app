import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_1/components/components.dart';

class LoginRegisterServices {
  final Dio dio = Dio();
  final GetStorage storage = GetStorage();
  final String apiUrl = 'https://mobileapis.manpits.xyz/api';

  void login(TextEditingController emailController, TextEditingController passwordController, BuildContext context) async {
    try {
      final response = await dio.post(
        "$apiUrl/login",
        data: {
          "email": emailController.text,
          "password": passwordController.text,
        },
      );
      print(response.data);

      if (response.data['success'] == true) {
        storage.write('token', response.data['data']['token']);
        Navigator.pushReplacementNamed(context, '/landingPage');
      } else {
        String errorMessage = response.data['message'] ?? 'Unknown error occurred';
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('An Error Occurred!'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'No'),
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      }
    } on DioException catch (error) {
      print("Error: ${error.message}");
      String errorMessage = 'An unexpected error occurred';
      if (error.response != null && error.response!.data is Map<String, dynamic>) {
        if (error.response!.data.containsKey('data')) {
          var errors = error.response!.data['data']['errors'];
          if (errors.isNotEmpty) {
            errorMessage = errors.values.first[0].toString();
          }
        } else {
          errorMessage = error.response!.data['message'] ?? 'An unknown error occurred';
        }
      }
      CustomShowDialog(
        text: errorMessage,
        noText: 'OK',
        onPressedNo: () {
          Navigator.pop(context, 'No');
        }, 
        onPressedYes: () {},
      );
    }
  }
}
